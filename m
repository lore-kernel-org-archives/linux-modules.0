MIME-Version: 1.0
In-Reply-To: <20170509190924.9087-2-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<20170509190924.9087-2-yauheni.kaliuta@redhat.com>
Date: Thu, 1 Jun 2017 19:18:07 -0700
Message-ID: <CAKi4VAKb1WA-qVkN2cbKZ4dpecj=qTCELWpPCg2L_82PZOQy-w@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] depmod: create depmod dir independent search function
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 9, 2017 at 12:09 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Prepare to implement external directories support.
>
> The patch splits depmod_modules_search() function to two
> functions: depmod_modules_search(), called by the high level with
> intention to search all possible modules, and
> depmod_module_search_path(), which takes path as a parameter and
> scans modules under the path only. Initially it is used to scan
> the same depmod->cfg->dirname path only.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Applied, thanks.

Lucas De Marchi
