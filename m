Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C9466B5E;
	Tue, 18 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058365; cv=none; b=PUxtpBKKnuf5saxEV58Nr1ubzFv3hUpvNlnjVGsx3V8ybQL5agw6Cd6Xtd68e5VDb5z7RJh1/+SSc4u+/u/ozHFwX2vd2Ch4ggcfP0VhE8SzX5WpRCzGvPQtcGWfkPSK093DyPD2Ey4PeaQQmB25CPqCnYFjfhbyBxtyRW7t8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058365; c=relaxed/simple;
	bh=YBeieDB5kfFVOEcZLPRUYPQueFxGkr3QeZO5RKShp7c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BMqloHQAXBYc3HSgoIjmz3rwRUWkkvZ/053yyTzUaG57U401E3sisdXiy6lzjVIE0/reOxEetCI0h4Zh7QnRByW39QlcoPf58q6ua7STxDrqZ0j2gtaiVENENPpJwYQm0mWlMh3mcT7ZGon4FuBmszOqCxdYYtGcWMZM/9EZ3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxX9O6WIRqNE4CAA--.7009S3;
	Tue, 18 Aug 2026 21:06:02 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX8+5WIRqmFoJAA--.59162S2;
	Tue, 18 Aug 2026 21:06:01 +0800 (CST)
Subject: Re: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping
 symbols during module load
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-4-yangtiezhu@loongson.cn>
 <4e351b13-1670-4813-ac98-e44c00703601@suse.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e2b3bc56-9b7d-b530-58a5-5afb00be307c@loongson.cn>
Date: Tue, 18 Aug 2026 21:06:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4e351b13-1670-4813-ac98-e44c00703601@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8+5WIRqmFoJAA--.59162S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrurykCr4fAw4kZry7Zr1xXrc_yoW8Jr1DpF
	W5Ga1jqF4kXF109anrWw1rWFy5K34DXw4UGrZ8K34IvF98XFySvrZrKw15uayDXr18JFy0
	vFW093sIvw1qkagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DU
	UUU

On 2026/8/18 下午7:59, Petr Pavlu wrote:
> On 8/12/26 5:28 AM, Tiezhu Yang wrote:
>> The compiler toolchains generate local and mapping symbols on certain
>> architectures like LoongArch for optimizations and relocations.
> 
> Nit: "local" -> "local label".

OK, will update the patch subject and commit message in v4.

>>
>> While the symbols are already filtered out during runtime lookups via
>> find_kallsyms_symbol(), they still leak into /proc/kallsyms for loaded
>> modules because layout_symtab() and add_kallsyms() do not filter them
>> during load time.
>>
>> Consequently, tracing tools like bpftrace (which do not perform internal
>> filtering, unlike perf) resolve identical addresses into confusing local
>> labels instead of actual clear C function names.
>>
>> Fix this by integrating the is_local_mapping_symbol() check directly into
>> the newly introduced is_kept_symbol() helper. This ensures these unneeded
>> symbols are stripped during module load time, keeping /proc/kallsyms clean
>> and resulting in accurate call stacks.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks,
Tiezhu

