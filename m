MIME-Version: 1.0
In-Reply-To: <1393589132-16467-1-git-send-email-mmarek@suse.cz>
References: <1393589132-16467-1-git-send-email-mmarek@suse.cz>
Date: Wed, 5 Mar 2014 12:22:10 -0300
Message-ID: <CAKi4VAJC_SondcK8S16Cpu+iUKw0UzuomAVGnvkbT-cpww8v8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] kmod_module_insert_module() cleanup and test coverage
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Fri, Feb 28, 2014 at 9:05 AM, Michal Marek <mmarek@suse.cz> wrote:
> Changes since v1
> 1/5: whitespace fixes
>      simplify allocations
>      report which modules are missing or excess
> 3/5: removed stray stat() marker
>
> Michal Marek (5):
>   testsuite: Check the list of loaded modules after a test
>   testsuite: Add test for modprobe --force
>   testsuite: Do not provide finit_module(2) on older kernels
>   Add some tests for kernels without finit_module(2)
>   libkmod-module: Simplify kmod_module_insert_module()

All patches in v2 have been applied. Thanks.

Lucas De Marchi
