MIME-Version: 1.0
In-Reply-To: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
References: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
Date: Fri, 4 Apr 2014 08:40:22 -0300
Message-ID: <CAKi4VA+EUL6c_RExVdzrpt=Ps3ayD5aLkzYyx2qbV0oaL1c7pQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix testsuite without zlib support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Apr 4, 2014 at 8:18 AM, Michal Marek <mmarek@suse.cz> wrote:
> Hi,
>
> here is the updated series. To avoid sending too big patch 1/3, I pushed
> the branch got git.kernel.org:
>
> The following changes since commit 8240333b257e96e7dc2ac2522f8bb7fb2158fafc:
>
>   config: also parse softdeps from modules (2014-04-01 08:13:54 -0300)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kmod.git testsuite-nocompression3
>
> for you to fetch changes up to 9324bb52f30cb6d0ff2828e1a63056d9c78960a1:
>
>   testsuite: Warn if sysconfdir is not /etc (2014-04-04 13:06:05 +0200)
>
>
> Michal Marek (3):
>   testsuite: Uncompress most modules
>   testsuite: Do not run tests with *.ko.gz if zlib is not enabled
>   testsuite: Warn if sysconfdir is not /etc

I`ve applied all of them.

Thanks.
Lucas De Marchi
