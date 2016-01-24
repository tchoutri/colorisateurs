#!/usr/bin/gawk -f


# The MIT License (MIT)
# 
# Copyright (c) 2016 Théophile Choutri <theophile@choutri.eu>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#### Usage
# tail -F access.log | ./access-colors.awk

function colorise_code(text)
{
    switch(text)
    {
        case "404":
            "(" (RED text RESET) ")"
            break
        case "200":
            "(" (BLUE text RESET) ")"
            break
        default:
            text
            break
        }
}

function colorise_method(text)
{
    switch (text)
    {
        case "GET":
            REQUEST = (MAGENTA text RESET)
            break
        case "PUT":
            REQUEST = (GREEN text RESET)
            break
        case "POST":
            REQUEST = (CYAN text RESET)
            break
        case "HEAD":
            REQUEST = (BLUE text RESET)
            break
        case "DELETE":
            REQUEST = (RED text RESET)
            break
        case "CONNECT":
            REQUEST = (BLUE text RESET)
            break
        case "TRACE":
            REQUEST = (YELLOW text RESET)
            break
        default:
            REQUEST = text
            break
        }
}

BEGIN {
    RED = "\033[1;31m"
    BLUE = "\033[1;34m"
    CYAN = "\033[1;36m"
    RESET = "\033[0m"
    GREEN = "\033[1;32m"
    YELLOW = "\033[1;33m"
    MAGENTA = "\033[1;35m"
    }

{
    gsub("\]","",$5)
    gsub("\"","",$6)
    colorise_method($6)
    colorise_code($9)
    
    printf (RED $1 RESET) " @ " (CYAN $4 "]" RESET CODE " " REQUEST " " $7) "\n"
}

