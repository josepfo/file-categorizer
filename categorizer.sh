#!/bin/bash
folder_path="$HOME/Downloads"

categories=("images" "videos" "documents" "archives" "audio" "others")

images=("jpeg" "jpg" "tiff" "gif" "bmp" "png" "bpg" "svg" "heif" "psd" "ai" "eps" "ico" "indd" "raw" "webp" "xcf" "tga" "exif" "hdr")
videos=("avi" "flv" "wmv" "mov" "mp4" "webm" "vob" "mng" "qt" "mpg" "mpeg" "3gp" "mkv" "rm" "swf" "asf" "asx" "mpa" "m4v" "svi" "3g2" "f4v" "m2v" "ts" "mxf" "ogv" "ogx" "ogg" "mod")
documents=("oxps" "epub" "pages" "docx" "doc" "fdf" "ods" "odt" "pwi" "xsn" "xps" "dotx" "docm" "dox" "rvg" "rtf" "rtfd" "wpd" "xls" "xlsx" "ppt" "pptx" "csv" "tsv" "xml" "yaml" "yml" "json" "pdf" "txt" "html" "xml" "css" "in" "out" "md" "tex" "nfo" "readme" "yml" "cfg" "conf" "config" "log")
archives=("a" "ar" "cpio" "iso" "tar" "gz" "rz" "7z" "dmg" "rar" "xar" "zip" "alz" "deb" "pkg" "rpm" "z" "zst" "lzma" "cab" "arj" "ace" "lzh" "lha" "lzip" "lz" "arc" "sfx" "partimg" "wim" "chm" "bz2" "tbz2" "tlz" "tbz" "txz" "tlzma" "xz" "txz")
audio=("aac" "aa" "dvf" "m4a" "m4b" "m4p" "mp3" "msv" "ogg" "oga" "raw" "vox" "wav" "wma" "flac" "alac" "ape" "aiff" "mid" "midi" "kar" "mka")

# Get a list of all files in the folder and store filenames in an array instead of a string
files=("$folder_path"/*)

# Check if the downloads folder exists
if [ ! -d "$folder_path" ]; then
    echo "Downloads folder not found."
    exit 1
fi

# Loop through all files in the folder
for filename in "${files[@]}"; do

    # Ignore directories 
    if [ -d "$folder_path/$filename" ]; then 
        continue
    fi

    file_extension="${filename##*.}"

    file_moved=0

    for category in "${categories[@]}"; do
        if [ $file_moved -eq 1 ]; then
            break
        fi
        case "$category" in
            "images")
                extensions=("${images[@]}")
                ;;
            "videos")
                extensions=("${videos[@]}")
                ;;
            "documents")
                extensions=("${documents[@]}")
                ;;
            "archives")
                extensions=("${archives[@]}")
                ;;
            "audio")
                extensions=("${audio[@]}")
                ;;
            *)
                extensions=() # Default to an empty array if category not found
                ;;
        esac

        if [ "${#extensions[@]}" -eq 0 ]; then # Leave the file as it is
            file_moved=1
            break
        fi

        for ext in "${extensions[@]}"; do
            if [ $ext == $file_extension ]; then # Move file to this category
                if [ -d "$folder_path/$category" ]; then
                    mv "$filename" "$folder_path/$category"
                else 
                    mkdir -p "$folder_path/$category"
                    mv "$filename" "$folder_path/$category"
                fi
                file_moved=1
                break
            fi
        done
    done
done

exit 1