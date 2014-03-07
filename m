MIME-Version: 1.0
In-Reply-To: <CAKi4VAJ+p26jpdy0XDs=owix2q=ROxNr_PDBqfFLPmomX3DZwQ@mail.gmail.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
	<1394114809-2737-8-git-send-email-lucas.demarchi@intel.com>
	<5318AECC.1020404@suse.cz>
	<CAKi4VAJ+p26jpdy0XDs=owix2q=ROxNr_PDBqfFLPmomX3DZwQ@mail.gmail.com>
Date: Thu, 6 Mar 2014 23:07:31 -0300
Message-ID: <CAKi4VA+2Z465Kri4S9GitHRuS_qejdaROM7uNx2pnYmNWxp9pg@mail.gmail.com>
Subject: Re: [PATCH 8/8] man: use systemd as example instead of udev
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 6, 2014 at 6:47 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
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
>
> It's this second case I'm referring to in the man page, since it
> relies on the devname alias that people put in each module.
>
> Lucas De Marchi


All patches are now  applied.

-- 

Lucas De Marchi
