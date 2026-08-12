Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C430DEA6;
	Wed, 12 Aug 2026 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498474; cv=none; b=ZZe+bz8/vcD1rHdn+2Vm+FtV01+5szG2MkNSXCxdb+7WtyQCbBtX4AmlbRfve9xHxjT+FuPzL1gythNY7jslrPeLYVnMd9mlcfYr+AYodU0PgLPqMdN8l6NuMpeqQhiDt4BF1gHpEYP9Ck2Ib/EidL1MJqiUGC90eRB6sPYs9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498474; c=relaxed/simple;
	bh=YE9zt04z5CZ6P7lf+VW7Fs/6VQ4jiP0JB8lVbLPQXnc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IO2gBn6NF6HMWFyVyeHoLNTYFxTo1wGtsS0ySTz/SXZLjVlXzKbYSEnA5rVa01ElQAHP+44K1q5EjsLXQSzKeoSMmlPAX0Jm/4p6OkOqmpRaisfru/vGCgF5P/ZujPSnd0SDTXQ3pZq5TQQ5rSR7EDiyqx87hPPeaha62YHioko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxutGhzXtqW2YAAA--.1219S3;
	Wed, 12 Aug 2026 09:34:25 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c6gzXtq5GwBAA--.9706S2;
	Wed, 12 Aug 2026 09:34:24 +0800 (CST)
Subject: Re: [PATCH v2] module/kallsyms: Filter out local mapping symbols
 during module load
To: Huacai Chen <chenhuacai@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260811071507.24043-1-yangtiezhu@loongson.cn>
 <39a48465-22b6-4b18-9f7e-ce258513181b@suse.com>
 <CAAhV-H5qN2=LEbVS+hd5Uohq6OKHgkxEWLg4GNukYFBmjEABHg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f933e156-1ef2-3abc-ef8f-b2688e78b957@loongson.cn>
Date: Wed, 12 Aug 2026 09:34:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5qN2=LEbVS+hd5Uohq6OKHgkxEWLg4GNukYFBmjEABHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c6gzXtq5GwBAA--.9706S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW7CFyrtF1xJr18trW3CFX_yoW8tr4kpF
	4qka1rXF4kZF13Can2vw1FgFy5WrWkWFW5J3Z8G3s7AFnxWFy0vrZrKw1Y934UAr1rJF1I
	qa12yasxZas8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

On 2026/8/11 下午10:22, Huacai Chen wrote:
> Hi, Petr,
> 
> On Tue, Aug 11, 2026 at 8:20 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 8/11/26 9:15 AM, Tiezhu Yang wrote:
>>> The compiler toolchains generate internal local labels on certain
>>> architectures (such as LoongArch) for optimizations and relocations.
>>>
>>> While these local labels are filtered out during runtime lookups in
>>> find_kallsyms_symbol(), they still leak into the permanent symbol
>>> tables of loaded modules, because layout_symtab() and add_kallsyms()
>>> do not check for the mapping symbols during layout generation.
>>>
>>> Consequently, tracing tools like bpftrace resolve identical addresses
>>> into confusing local labels instead of actual clear C function names.
>>>
>>> Fix this by adding is_mapping_symbol() checks directly into the symbol
>>> tracking loops of layout_symtab() and add_kallsyms(). This prevents the
>>> mapping symbols from entering the module's memory symbol arrays at load
>>> time.
>>
>> This optimization looks sensible to me. Kallsyms in vmlinux also
>> normally doesn't include information about local labels (.L<xyz>) and
>> mapping symbols ($a, $d, ...), so it should be ok not to track them in
>> modules either.
>>
>> Note that the patch description mixes up these two symbol categories,
>> presumably because the existing is_mapping_symbol() function conflates
>> them as well.

...

>> It is better to avoid duplicating the same logic in layout_symtab() and
>> add_kallsyms(). The function is_core_symbol() can be renamed to
>> something like is_kept_symbol() and can be solely responsible for
>> deciding what to keep.
> I'm sorry but I think Tiezhu's patch is simpler and cleaner. :)

Hi Petr and Huacai,

Thanks for your feedback! To make the code cleaner, I plan to split the
changes into the following three patches for v3:

1. module/kallsyms: Rename is_mapping_symbol() to is_local_mapping_symbol()
2. module/kallsyms: Refactor current symbol filtering into is_kept_symbol()
3. module/kallsyms: Filter out local and mapping symbols during module load

I will send out the v3 patch series soon.

Thanks,
Tiezhu

