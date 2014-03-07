Return-Path: <mmarek@suse.cz>
Message-ID: <53198EAA.6000600@suse.cz>
Date: Fri, 07 Mar 2014 10:17:30 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 8/8] man: use systemd as example instead of udev
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com> <1394114809-2737-8-git-send-email-lucas.demarchi@intel.com> <5318AECC.1020404@suse.cz> <CAKi4VAJ+p26jpdy0XDs=owix2q=ROxNr_PDBqfFLPmomX3DZwQ@mail.gmail.com>
In-Reply-To: <CAKi4VAJ+p26jpdy0XDs=owix2q=ROxNr_PDBqfFLPmomX3DZwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On 2014-03-06 22:47, Lucas De Marchi wrote:
> On Thu, Mar 6, 2014 at 9:22 AM, Michal Marek <mmarek@suse.cz> wrote:
>> On 2014-03-06 15:06, Lucas De Marchi wrote:
>>> Nowadays udev doesn't create nodes in /dev anymore. This role is rather
>>                               ^static
>>
>> As of writing this, udev still takes care of "normal" device nodes.
>>
> 
> nops... it doesn't even have the capability to create nodes anymore:
> http://cgit.freedesktop.org/systemd/systemd/commit/units/systemd-udevd.service.in?id=edeb68c53f1cdc452016b4c8512586a70b1262e3
> 
> I don' t know what you mean by normal device node... but udev now
> relies on 2 sources for creating nodes:
> 
> 1) devtmpfs in the kernel
> 2) systemd-tmpfiles, that runs on early boot taking the output of
> 'kmod static-nodes'

Ah, I didn't know that devtmpfs is mandatory now.

Michal
