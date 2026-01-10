#!/bin/bash
#
# Copies in the scripts and things into user home dir.

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo "WARNING: This clobbers existing files like .bashrc."
echo "         Recommend that you leave a previous terminal window open so you can revert if needed."
echo "Proceed? (y/n)"
read doIt

if [ "x${doIt}" != "xy" ] ; then
    echo "ok, bailing out now"
    exit 1
fi

BACKUP_DIR="${HOME}/deploy_backup"
dotPrefix="DOT_"

# only one layer of backups though. Existing/previous backup files in the backup path are clobbered!
echo "Making a backup of the original scripts to ${BACKUP_DIR}"

# These files all start with "." so they are hidden (the dot is part of their filename)
hiddenFileList="bashrc Xresources bashfuncs aliases emacs dircolors"

mkdir "${BACKUP_DIR}"
for i in ${hiddenFileList}
do
    # Back up the for original file by copying it into a backup path
    targetFile="${HOME}/.${i}"
    backupFile="${BACKUP_DIR}/${i}.orig"
    [[ -e ${targetFile} ]] && cp -f ${targetFile} ${backupFile}

    dotFile="${SCRIPT_DIR}/${dotPrefix}${i}"
    echo "create/copy ${targetFile}"
    cp -f ${dotFile} ${targetFile}
done

mkdir ${HOME}/bin
cp ${SCRIPT_DIR}/bin/* ${HOME}/bin

echo "Files copied. I suggest you Validate things are good (backups can be found in ${BACKUP_DIR} if needed)"
