MIME-Version: 1.0
In-Reply-To: <1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <20150209222251.GA22303@localhost>
	<CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
	<1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Date: Tue, 10 Feb 2015 08:33:41 -0200
Message-ID: <CAKi4VA+gExxizer+rbKAQWzYLL9S3kv8Pupk0QHv44g9fkTLMg@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 10, 2015 at 6:26 AM, Tobias St=C3=B6ckmann <tobias@stoeckmann.o=
rg> wrote:
> If it works, i.e. the poc.ko module doesn't trigger a segmentation fault,=
 I am
> fine with that solution. When it's in the tree, I will create fixes for t=
he
> other occurrences in that style as well.

yeah, it works

kmod $ ./tools/modinfo ~/Downloads/poc.ko
filename:       /home/lucas/Downloads/poc.ko
modinfo: ERROR: could not get modinfo from 'poc': Invalid argument

--=20
Lucas De Marchi
