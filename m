Return-Path: <mtk.manpages@gmail.com>
Return-Path: <mtk.manpages@gmail.com>
Cc: mtk.manpages@gmail.com, linux-modules <linux-modules@vger.kernel.org>
Subject: Re: SYNOPSIS not showing many options in
 http://man7.org/linux/man-pages/man8/modprobe.8.html
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, hj@howardjohnson.name
References: <9c4edcc4-9a7e-ad4c-709f-f375e74c207c@gmail.com>
 <aef4afd6-c230-b8bc-cec5-a3ddcc541af5@HowardJohnson.name>
 <CAKi4VA+OmbYiNbXTG-8vfgW5CmFbE+tyKQw9+ucuU4rHoamgvQ@mail.gmail.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <423c2b14-eb31-ec42-2503-a8342e83506a@gmail.com>
Date: Tue, 21 Aug 2018 11:55:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAKi4VA+OmbYiNbXTG-8vfgW5CmFbE+tyKQw9+ucuU4rHoamgvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-modules.vger.kernel.org>

On 06/25/2018 11:54 PM, Lucas De Marchi wrote:
> CC'ing Michael
> 
> Lucas De Marchi

(Not one of the pages I maintain.)

Bug reports for this manual page should be handled as described here:
http://man7.org/linux/man-pages/man8/modprobe.8.html#COLOPHON

Thanks,

Michael

> On Fri, Jun 22, 2018 at 11:27 AM Howard Johnson <hj@howardjohnson.name> wrote:
>>
>>  > In the SYNOPSIS for http://man7.org/linux/man-pages/man8/modprobe.8.html
>>
>>> these options aren't shown:
>>>
>>> **-a, --all
>>> -d, --dirname
>>> --first-time
>>> --force-vermagic
>>> --force-modversion
>>> -f, --force
>>> -R, --resolve-alias
>>> -S, --set-version
>>> --show-depends
>>> -s, --syslog
>>>
>>>         *modprobe *[*-v*] [*-V*] [*-C */config-file/] [*-n*] [*-i*] [*-q*] [*-b*] [/modulename/]
>>>                  [/module parameters/...]
>>>
>>>         *modprobe *[-r] [*-v*] [*-n*] [*-i*] [/modulename/...]
>>>
>>>         *modprobe *[-c]
>>>
>>>         *modprobe *[--dump-modversions] [/filename/]
>>>
>>>
>>> I don't know; is the SYNOPSIS just out of date, or are these options
>>> that can be used anywhere?
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
