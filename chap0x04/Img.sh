#!/usr/bin/env bash
quality="70"            
RESOLUTION="50%x50%"    
watermark=""            
Q_FLAG="0"
R_FLAG="0"
W_FLAG="0"
C_FLAG="0"
H_FLAG="0"
PREFIX=""
POSTFIX=""
DIR=`pwd`              

#输出帮助信息
Useage()   
{
  echo "Useage:bash test.sh  -d <directory> [option|option]"
  echo "options:"
  echo "  -d [directory]                      目标文件路径"
  echo "  -q|--quality [number]               对jpg图像进行质量压缩，默认quality=70"
  echo "  -r|--resize [width*height|width]    图像分辨率压缩，默认50%"
  echo "  -w|watermark [watermark]            添加水印"
  echo "  --prefix[prefix]                    添加前缀"
  echo "  --postfix[postfix]                  添加后缀"
  echo "  -c                                  png/svg 统一转换为 jpg"
}

main()
{
#若路径格式正确则新建一个输出文件夹，存放处理后的图片 
if [ ! -d "$DIR" ] ; then
  echo "No such directory"
  exit 0
else
 output=${DIR}/output
 mkdir -p $output
fi

#初始化 
command="convert"
IM_FLAG="2"

#JPEG压缩
if [[ "$Q_FLAG" == "1" ]]; then
  IM_FLAG="1"
  command=${command}" -quality "${quality}
fi

#保持原始宽高比,同时压缩分辨率
if [[ "$R_FLAG" == "1" ]]; then
  command=${command}" -resize "${RESOLUTION}
fi

#添加水印
if [[ "$W_FLAG" == "1" ]]; then
  echo ${watermark}
  command=${command}" -fill white -pointsize 40 -draw 'text 10,50 \"${watermark}\"' "
fi

#转换格式
if [[ "$C_FLAG" == "1" ]]; then
  IM_FLAG="2"
fi

#根据需要获取对应后缀的图片  imgs中存储的是绝对路径
case "$IM_FLAG" in
       1) images=`find $DIR -maxdepth 1 -regex '.*\(jpg\|jpeg\)'` ;;
       2) images=`find $DIR -maxdepth 1 -regex '.*\(jpg\|jpeg\|png\|svg\)'` ;;
esac

#根据指令处理每一个文件
for CURRENT_IMAGE in $images; do
     filename=$(basename "$CURRENT_IMAGE")  #只取出文件名
     name=${filename%.*}                    #去掉后缀   
     suffix=${filename#*.}                  #取出后缀    
     if [[ "$suffix" == "png" && "$C_FLAG" == "1" ]]; then
       suffix="jpg"
     fi
     if [[ "$suffix" == "svg" && "$C_FLAG" == "1" ]]; then
       suffix="jpg"
     fi
     savefile=${output}/${PREFIX}${name}${POSTFIX}.${suffix}  #重新拼出一个存储路径
     temp=${command}" "${CURRENT_IMAGE}" "${savefile}  #指令 需要执行操作的图片路径  图片操作后存储路径

     #运行拼凑出来的指令
     eval $temp
done

exit 0

}

#从命令行中获取参数 
TEMP=`getopt -o cr:d:q:w: --long quality:arga,directory:,watermark:,prefix:,postfix:,help,resize: -n 'test.sh' -- "$@"`
eval set -- "$TEMP"

while true ; do
    case "$1" in
    
		-d|--directory)
            case "$2" in
                "") shift 2 ;;
                 *) DIR=$2 ; shift 2 ;;
            esac ;;
            
        -q|--quality) Q_FLAG="1";
            case "$2" in
                "") shift 2 ;;
                 *) quality=$2; shift 2 ;;  
            esac ;;
            
        -r|--resize) R_FLAG="1";
            case "$2" in
                "") shift 2 ;;
                *)RESOLUTION=$2 ; shift 2 ;;
            esac ;;
            
        -w|--watermark)
			W_FLAG="1"; watermark=$2; shift 2 ;;
         
        --prefix) 
			PREFIX=$2; shift 2;;

        --postfix) 
			POSTFIX=$2; shift 2 ;;
        
        -c) 
			C_FLAG="1" ; shift ;;

        --help) 
			Useage; shift ;;

        --) 
			shift ; break ;;
			
        *) 
			echo "Internal error!" ; 
			exit 1 ;;
			
    esac
done

main