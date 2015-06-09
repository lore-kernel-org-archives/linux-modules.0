MIME-Version: 1.0
In-Reply-To: <20150609073429.GA9053@bongo.bofh.it>
References: <CAKi4VAKaZPtGvT9gwTOmoTG8mpnn05ybSSeNde8VPOcczLuChg@mail.gmail.com>
	<20150609073429.GA9053@bongo.bofh.it>
Date: Tue, 9 Jun 2015 16:42:10 -0300
Message-ID: <CAKi4VAJLLB1nW5GTR_8JhORCFLudQULbT1m=F1TraMmPjJnBJw@mail.gmail.com>
Subject: Re: [ANNOUNCE] kmod 21
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jun 9, 2015 at 4:34 AM, Marco d'Itri <md@linux.it> wrote:
> On Jun 09, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>
>>         - kmod tool started to learn the "insert" and "remove" commands that
>>           are the simplified versions of the older modprobe tool.  These
>>           commands are still work in progress so they are hidden behind a
>>           --enable-experimental flag during build.  It should not be enabled
>>           unless you know what you're doing.
> Should I enable it in Debian testing/unstable or do you see this as
> strictly developers-only?

Right now developers only and for people wanting to experimenting an
unstable interface. We may change/remove it in future as we please.

So... for Debian or any other big distros I'd say you shouldn't enable.


-- 
Lucas De Marchi
