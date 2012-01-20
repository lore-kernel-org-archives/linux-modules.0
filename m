Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1326861219.490.4.camel@cr0>
References: <1326819051-25712-1-git-send-email-lucas.demarchi@profusion.mobi> <1326861219.490.4.camel@cr0>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Fri, 20 Jan 2012 17:40:58 +0100
Message-ID: <CAPXgP12vChg=820uamRa6dTekEQD_xa6mg-nroOm1br+7-JCqw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: do not check for ancient modutils tools
To: Cong Wang <amwang@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 18, 2012 at 05:33, Cong Wang <amwang@redhat.com> wrote:
> On Tue, 2012-01-17 at 14:50 -0200, Lucas De Marchi wrote:
>> scripts/depmod.sh checks for the output of '-V' expecting that it has
>> module-init-tools in it. It's a hack to prevent users from using
>> modutils instead of module-init-tools, that only works with 2.4.x
>> kernels. This however prints an annoying warning for kmod tool, that is
>> currently replacing module-init-tools.
>>
>> Rather than putting another check for kmod's version, just remove it
>> since users of 2.4.x kernel are unlikely to upgrade to 3.x, and if they
>> do, let depmod fail in that case because they should know what they are
>> doing.
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@profusion.mobi>
>
> Acked-by: WANG Cong <amwang@redhat.com>

Michal, mind picking this up? The warning it produces with kmod is
really misleading, and the check seems unnecessary these days.

  Acked-By: Kay Sievers <kay.sievers@vrfy.org>

Thanks,
Kay
