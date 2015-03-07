MIME-Version: 1.0
In-Reply-To: <1425735173-24181-1-git-send-email-caio.oliveira@intel.com>
References: <1425735173-24181-1-git-send-email-caio.oliveira@intel.com>
Date: Sat, 7 Mar 2015 12:21:02 -0300
Message-ID: <CAKi4VAJ8acT6gvCvfjLyCCO-+WQ1tjNAYQSdFdF98-vZhU8zdg@mail.gmail.com>
Subject: Re: [PATCH] tools: add basic versions of insert and remove
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Mar 7, 2015 at 10:32 AM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> ---
>
> Differences from v1:
>
> * Added updated copyright to insert.c, remove.c. Added license and
>   copyright to test-tools.c.
>
> * Rewrote error handling in insert to ensure EXIT_FAILURE will be
>   returned if any of the modules fail to load.
>
> * Minor style fixes.

Applied, thanks.

-- 
Lucas De Marchi
