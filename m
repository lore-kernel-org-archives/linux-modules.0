Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71455301486
	for <linux-modules@vger.kernel.org>; Tue, 25 Aug 2026 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621985; cv=none; b=Lm7zn7AWSNWRtIETFrWMZnZ3Y1Jo1T9358DIF41eFDvx8NL1n7EVJxiHkorDKAwS/lylDO9OTgOHBjVzap9Q7k7wQV/Wnc5YOZU2LFp3O3mYOHubHBHN93X1gzEsffK2PXaGOiHHRTSYmauF08W/UqadsPaQIVGvaO1AN/P7rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621985; c=relaxed/simple;
	bh=mJDXCxP/QHfH0D2kTzRvtAGHdsJjvKERLN12qs4e2xg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lWQT5LH6kzyh/Rd/ORwubVlz0t91GEHEG+gzSfR5zxHZqYgm9XzaEVTeTheSBwZKkdyTKuUPwG4ULDw2YrCOb4iGOE8EPw2Pmo2utu/r3ZI9daXIj4ymItTI4jjhUzK6rBNZIWtfJciso1Po2aYpmGycmVm/nQABJ10Cvuvg0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9NW8oxqGKIEAA--.13216S3;
	Tue, 25 Aug 2026 09:39:34 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs1V8oxqTkoRAA--.55611S2;
	Tue, 25 Aug 2026 09:39:33 +0800 (CST)
Subject: Re: [PATCH v4 1/3] module/kallsyms: Rename is_mapping_symbol() to
 is_ignored_kernel_symbol()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,
 loongarch@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Namhyung Kim <namhyung@kernel.org>
References: <20260820125007.22943-1-yangtiezhu@loongson.cn>
 <20260820125007.22943-2-yangtiezhu@loongson.cn>
 <CAAhV-H5ihmy7REGKkid3jKqZ0_KJU5js37ZrNFp7HmWYtuHzpA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <49a9e04d-64fc-3bd9-4a6c-a3b9d22492b5@loongson.cn>
Date: Tue, 25 Aug 2026 09:39:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5ihmy7REGKkid3jKqZ0_KJU5js37ZrNFp7HmWYtuHzpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs1V8oxqTkoRAA--.55611S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF45Gr45JryUZw4DKry7CFX_yoWfCwc_Kw
	4Ikrn8CFs3Aw4Skw4UKr93XF4Ygws8WrZxXw1UX3ySqasYyr98Jwn3Gry8AF1Dur4kCFsx
	tFn7uF93try7CosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

On 2026/8/24 下午4:45, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Thu, Aug 20, 2026 at 8:50 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The helper function is_mapping_symbol() historically checks for both
>> local labels prefixed with ".L" or "L0" and mapping symbols prefixed
>> with "$".
>>
>> Rename it to is_ignored_kernel_symbol() to better reflect this actual
>> behavior and scope, preventing conceptual confusion.
> I think is_ignored_symbol() is enough, no "kernel" needed.

Hi Huacai,

Using is_ignored_kernel_symbol() was suggested by Petr [1] to maintain
consistency with the existing naming convention in tools/perf.

For me, either is_ignored_kernel_symbol() or is_ignored_symbol() is
fine. I will leave it to Petr to make the final call on this.

[1] 
https://lore.kernel.org/loongarch/96b0e23b-165d-4026-bdfe-f8cd8ceb36ba@suse.com/

Thanks,
Tiezhu

