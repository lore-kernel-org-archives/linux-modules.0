Return-Path: <mmarek@suse.cz>
Message-ID: <53102F8E.1020801@suse.cz>
Date: Fri, 28 Feb 2014 07:41:18 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 3/5] testsuite: Do not provide finit_module(2) on older
 kernels
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz> <1393541533-14719-4-git-send-email-mmarek@suse.cz> <CAKi4VALWBwufCSaMU4t3w+NYDEzyc5ap5ncObb=b=r0_VUWKiQ@mail.gmail.com>
In-Reply-To: <CAKi4VALWBwufCSaMU4t3w+NYDEzyc5ap5ncObb=b=r0_VUWKiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Dne 28.2.2014 07:37, Lucas De Marchi napsal(a):
> On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
>> +       if (!check_kernel_version(3, 8)) {
>> +               stat("/old/kernel", &st);
> 
> leftover?

Yes, sorry.

Michal
