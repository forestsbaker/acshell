#!bin/bash

function setVi2Vim()
{
        VI_IN_BASH=`grep vim ~/.bashrc`
        if [ -z "$VI_IN_BASH" ];then
                echo "alias vi='vim'" >> ~/.bashrc
                source ~/.bashrc
        fi
}


