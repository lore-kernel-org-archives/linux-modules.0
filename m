Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55228850E;
	Tue, 18 Aug 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058313; cv=none; b=l9eHFF/rLtsPgq33hjrPboCwTs75C5qHc0sU1Brv40svpcWDUQN15EIpM+L74dfJWjz5iy4qTHJ6z80zy+xbUouTBETs2jvZZRSkzVm1hgLl3Epkq6TqgddaPz86vqHgk8o9JfY8dC2iCJwptA6lc3sU4+ZYQNrnXBZRTfXkR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058313; c=relaxed/simple;
	bh=de/4KqsG1Ym+WbmsWHNVHBGYDCoajxmbj1ko9zwYxN0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DQVvFYfBA0fAlAlJ33fcp1doMe4uwrdFdZ2idJAtMDotEzQs1+0IFBGUpR95DsUsNSniFNHuf/AJWb5oxLDV8NsbbfnnsGTbZrhHlUQ72/ijGQh1s8lBexcNF6iUtsu7l5xpLjDtqKbqYsR1bLJuRwNFks1ZR4pKWXVETt2qa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxKvCFWIRqEU4CAA--.6762S3;
	Tue, 18 Aug 2026 21:05:09 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxmM2EWIRqXFoJAA--.57652S2;
	Tue, 18 Aug 2026 21:05:08 +0800 (CST)
Subject: Re: [PATCH v3 2/3] module/kallsyms: Refactor current symbol filtering
 into is_kept_symbol()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-3-yangtiezhu@loongson.cn>
 <674042ea-243c-48f5-8010-9181f3e99f06@suse.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b58a0189-b471-670d-e235-73059552a9a4@loongson.cn>
Date: Tue, 18 Aug 2026 21:05:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <674042ea-243c-48f5-8010-9181f3e99f06@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM2EWIRqXFoJAA--.57652S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar45CrW5ZFy5Ww4DXr43urX_yoW8JFW8pr
	WUCw4jvF4kXF1kua1qyFW5ZFyfG3s7XrWDXFsxGFWxAFn8W34rtr92kw15Kw4kZrn7tF1x
	ZFWSvasrZa45AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4BHqDU
	UUU

On 2026/8/18 下午7:58, Petr Pavlu wrote:
> On 8/12/26 5:28 AM, Tiezhu Yang wrote:
>> Currently, the loops in layout_symtab() and add_kallsyms() duplicate the
>> exact same checks (i == 0 || is_livepatch_module() || is_core_symbol())
>> to determine whether a symbol should be preserved in the module's core
>> symbol table.
>>
>> Rename is_core_symbol() to is_kept_symbol() and move the entire checking
>> logic inside it, including the special handlers for the first symbol and
>> livepatch modules.
>>
>> No functional change.
>>
>> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Looks ok to me. I'm also fine also keeping the current name,
> is_core_symbol(), as Huacai mentions in his review [1]. I previously
> suggested is_kept_symbol() [2], since the is_livepatch_module() check
> is moved into this function. However, is_core_symbol() is still ok, as
> it is consistent with where the symbols are assigned, in
> module::core_kallsyms.

OK, let me use is_core_symbol() in v4.

> The important part is to avoid duplicating the checks that determine
> whether a symbol should be kept in layout_symtab() and add_kallsyms().
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks,
Tiezhu

