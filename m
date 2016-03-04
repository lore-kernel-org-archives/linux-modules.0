MIME-Version: 1.0
In-Reply-To: <20160302171020.GA9719@bongo.bofh.it>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
	<20160302155551.GA31679@bongo.bofh.it>
	<1456934860.3200.4.camel@intel.com>
	<20160302171020.GA9719@bongo.bofh.it>
Date: Fri, 4 Mar 2016 02:04:49 -0300
Message-ID: <CAKi4VALu1pfKMDtt98Jn4Jub1n8dJ8U9_VbSgZWYDQfg482LWA@mail.gmail.com>
Subject: Re: [PATCH] modprobe: install default configuration
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "lkundrak@v3.sk" <lkundrak@v3.sk>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 2, 2016 at 2:10 PM, Marco d'Itri <md@linux.it> wrote:
> On Mar 02, "De Marchi, Lucas" <lucas.demarchi@intel.com> wrote:
>
>> Marco, could you be more specific on how this breaks userspace? It
> It breaks the expectation that loading the module will make dummy0
> appear.
> But if there is an agreement that this should be changed then I believe
> that it should be changed in the kernel to be sure to have the same
> default across different distributions.

I fear that due to the problem with make oldconfig not changing the
behavior it's easier to have the same default across distros by
changing it here than by changing it in the kernel.

Lucas De Marchi
