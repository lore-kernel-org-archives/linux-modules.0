MIME-Version: 1.0
In-Reply-To: <1421840243-26082-4-git-send-email-caio.oliveira@intel.com>
References: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
	<1421840243-26082-4-git-send-email-caio.oliveira@intel.com>
Date: Wed, 21 Jan 2015 10:21:24 -0200
Message-ID: <CAKi4VAKMf-f21qTBHjGyXte1Di7qXm9E=7GLL_S0xMZDVo4XaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] util: remove dead code in freadline_wrapped
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 21, 2015 at 9:37 AM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> Each loop iteration starts with 'i < size'. When i is changed
> the invariant is kept by checking if 'i == size' and growing the
> buffer.
> ---
>  shared/util.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)


Applied

-- 
Lucas De Marchi

-- 
Lucas De Marchi
