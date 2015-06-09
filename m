MIME-Version: 1.0
In-Reply-To: <20150607091742.GA8285@rhlx01.hs-esslingen.de>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
	<1433658449-3931-4-git-send-email-lucas.de.marchi@gmail.com>
	<20150607091742.GA8285@rhlx01.hs-esslingen.de>
Date: Mon, 8 Jun 2015 22:42:06 -0300
Message-ID: <CAKi4VALwFnq2RBFxkwVAq6JbE58JmorofL73x7R_cW1Yy4o2Cg@mail.gmail.com>
Subject: Re: [PATCH kmod 3/3] tools: display features together with version information
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andreas Mohr <andi@lisas.de>
Cc: linux-modules <linux-modules@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, Bertrand Jacquin <beber@meleeweb.net>,
	"Marco d'Itri" <md@linux.it>, lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jun 7, 2015 at 6:17 AM, Andreas Mohr <andi@lisas.de> wrote:
> Hi,
>
> On Sun, Jun 07, 2015 at 03:27:29AM -0300, lucas.de.marchi@gmail.com wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>> diff --git a/tools/kmod.c b/tools/kmod.c
>> index c9d2cc8..28217df 100644
>> --- a/tools/kmod.c
>> +++ b/tools/kmod.c
>> @@ -114,6 +114,7 @@ static int handle_kmod_commands(int argc, char *argv[])
>>                       return EXIT_SUCCESS;
>>               case 'V':
>>                       puts("kmod version " VERSION);
>> +                     puts(KMOD_FEATURES);
>>                       return EXIT_SUCCESS;
>
> Hmm - seems kmod.c is the only component
> which open-codes literals
> rather than making use of PACKAGE define?
> If this is not intended,
> then it would probably be useful
> to have another correction commit prior to this one
> included in the series,
> to have this one gain properly fully symmetric content.

Indeed. I just added a commit doing that and pushed to master.

thanks

-- 
Lucas De Marchi
