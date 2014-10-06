MIME-Version: 1.0
In-Reply-To: <54323906.1050808@web.de>
References: <54303DF6.4050203@web.de>
	<54310A74.3090404@redhat.com>
	<54310C04.5060008@web.de>
	<54310DF9.8070904@redhat.com>
	<54310FFF.10504@web.de>
	<543112A6.8070503@redhat.com>
	<543113FF.7050900@web.de>
	<54311549.4070808@redhat.com>
	<5431258D.3020904@web.de>
	<54323906.1050808@web.de>
Date: Mon, 6 Oct 2014 19:43:42 -0300
Message-ID: <CAKi4VALAtSKjoWnP5ynE1aYzomndL3=d6xxA+=10Ue4dDDa0AA@mail.gmail.com>
Subject: Re: [solved] Re: uas module not loaded automatically
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-modules <linux-modules@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Oct 6, 2014 at 3:39 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2014-10-05 13:03, Jan Kiszka wrote:
>> Hi all,
>>
>> I'm migrating this conversation over from LKML as it is probably a kmod
>> issue. I've just retried the scenario with kmod 18 (from OpenSUSE
>> Factory) and can still confirm it. Please see below for details.
>
> Mystery solved:
>
> /etc/modprobe.d/50-blacklist.conf:
> # uas has been confirmed to be hopelessly broken
> # Bug bnc#770301
> blacklist uas
>
> I'll check with my distro if this is gone in their next release when
> they switch to a UAS-enabled kernel. The official kernel for their
> current release still has it disabled, the problem only occurred when
> moving to a newer kernel.

nice to see the blacklist is working fine :)

-- 
Lucas De Marchi
