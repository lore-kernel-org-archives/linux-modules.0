MIME-Version: 1.0
In-Reply-To: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
Date: Fri, 28 Feb 2014 03:03:12 -0300
Message-ID: <CAKi4VA+3Fo8yN0DJNFvsh_7sbxmfRi5X528LeZ6n=kUayWQTRA@mail.gmail.com>
Subject: Re: [PATCH 0/5] kmod_module_insert_module() cleanup and test coverage
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Michal,

On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
> I only wanted to send the kmod_module_insert_module() patch after passing
> the testsuite, but then I noticed the testsuite is hardly testing it :).
>
> Michal
>
> Michal Marek (5):
>   testsuite: Check the list of loaded modules after a test
>   testsuite: Add test for modprobe --force
>   testsuite: Do not provide finit_module(2) on older kernels
>   Add some tests for kernels without finit_module(2)
>   libkmod-module: Simplify kmod_module_insert_module()

It's pretty good. Thanks.

I only have some cosmetic comments. I can make the changes when
applying if you prefer. See in the individual patches.

Lucas De Marchi
