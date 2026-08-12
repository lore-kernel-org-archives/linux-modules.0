Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739003002DD
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786508356; cv=none; b=k5bj/V/Te6qY8e6i1Rgq8wcZJxcUdWj1TydbYNGDiaFAFdl01VPqYsovzqBSLvuL6hYMS3QAdGTGURgwF4bX+Nvu9uZcI747JpkT1fbzzL55XeRNlt96Qud+nVpRewJh1lBBX9gL1thdPAnpWhxZ9JYXUEfgR4fGRYqceSogr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786508356; c=relaxed/simple;
	bh=kyWuVwDHDZwQqMzpX/78Rp68PO8hrk0L1annhXEhrh8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K9PEX2ArBZWzAAYtaxwe67DJqyinVpJYTxJkPerkLHIYpb05ISh2ShJVH02CllggKXX5ueNRRbQn3jvJb0S/vuw5ZRz+HPIBWK6CaNXRodVvm8+Vh7L9QBveXv0Um3qgI04Rre3+VOGALl/UjlDS3zvJD5Umc8AmSzpD+bbzeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxYdFB9HtqRW4AAA--.1419S3;
	Wed, 12 Aug 2026 12:19:13 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c479HtqJZEBAA--.10850S2;
	Wed, 12 Aug 2026 12:19:08 +0800 (CST)
Subject: Re: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping
 symbols during module load
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-4-yangtiezhu@loongson.cn>
 <20260812034416.DAB981F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0cd4c5c8-3c50-958f-a8c8-9f118a14a57c@loongson.cn>
Date: Wed, 12 Aug 2026 12:19:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260812034416.DAB981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c479HtqJZEBAA--.10850S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
	xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
	17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	zpBTUUUUU

On 2026/8/12 上午11:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
...

> [Severity: High]
> This is a pre-existing issue

Thanks for the reports of patch 2 and patch 3.

As noted in the descriptions, these are pre-existing issues,
they are completely independent of this series.

IMO, a dedicated security patch series should handle this
historical vulnerability in the future.

Thanks,
Tiezhu

