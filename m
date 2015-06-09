MIME-Version: 1.0
In-Reply-To: <20150607092506.GA14394@rhlx01.hs-esslingen.de>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
	<20150607092506.GA14394@rhlx01.hs-esslingen.de>
Date: Mon, 8 Jun 2015 22:41:11 -0300
Message-ID: <CAKi4VAJEPQ9bx72kpjpWVAcq+uUA0r7FyPRpJh2UL=nY2QaLKQ@mail.gmail.com>
Subject: Re: [PATCH kmod 0/3] Add feature list together with version
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andreas Mohr <andi@lisas.de>
Cc: linux-modules <linux-modules@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, Bertrand Jacquin <beber@meleeweb.net>,
	"Marco d'Itri" <md@linux.it>, lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jun 7, 2015 at 6:25 AM, Andreas Mohr <andi@lisas.de> wrote:
> Hi,
>
> On Sun, Jun 07, 2015 at 03:27:26AM -0300, lucas.de.marchi@gmail.com wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Sample output:
>>
>> $ ./tools/kmod --version
>> kmod version 20
>> +XZ +ZLIB -EXPERIMENTAL
>
> Thank you for this important feature!
> (which follows systemd format
> as proposed by Kay Sievers)
>
> While we're quite firmly on the non-kernel side here,
> I'll still scribble my
> Reviewed-by: Andreas Mohr <andim2@users.sf.net>

Thanks, I now pushed it to master branch.

-- 
Lucas De Marchi
