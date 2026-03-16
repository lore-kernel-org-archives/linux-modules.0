Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE226ED3E
	for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671004; cv=none; b=um5ff1Ge8gwTLraaHiPSdA44DjYuU674d5H2ukGXrZdd6HUDH3IoJXmJu0ibbwedBiyXi0l8h2dTqiBYeJLZewsHs2/41+vnCb79aQ9YGBQ2fEmLw/HtoeTWHLaY+75fcap858RrzmMpHQb691cZrZQb3FWpGi8+HYmL4vVZSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671004; c=relaxed/simple;
	bh=1jL8wE53ez09VmWxBwheIuOofd4JrIq2MvGzCJVFSK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JagOt7sd7ixFogvg1PemMpj15nd7jSAQkYsdiHhzQbo7IaXpvb8MXaUigK3ALalpEGNuJ51IQZfTzNkbZdjeN86DKNRk//WeuGAo6eCetznadkecNkRPkY1zWA7ffte73XVI8b1H/XUtZGueESnk9oQTWmVk6TTPV41ApGDlxs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uvu/quro; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uvu/quro"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-663a6bb0fa1so5561999a12.3
        for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773671001; x=1774275801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gq20qf8GOfZpeWKB6LCgq1j0kTfiDeFW7gACX+xgRqM=;
        b=Uvu/qurocdZAxm/GpV7rDiqwVaYhrhgfTphpAc1+8Kout2wSDQOUC3Nt6rLtpr/I8n
         EkBeqmZYm+t3q2ciqEAfTPIve4FF9a180iKDRo1srnae6LZFDYFaRqULnrHtvJG7qsCV
         2V4YcF6AiGRJ5Yf/VkSPTshHwHSq7wdz4FkcG77Dy5G3bvi+XGyZSTqmq4s3et8dttHW
         uZ5ZfNMa0cMFtybIptoEDiwzwo5M0ydCqqr8N52wU2i6B9GtOUUDv58O5KAdM/YrJy+R
         pKMbTLEgnDxVyNfu6doMJOXtfFjjBxktELsnv2HBBtBA56y20vyQtIT09+ts3lIYXQL7
         FwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671001; x=1774275801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq20qf8GOfZpeWKB6LCgq1j0kTfiDeFW7gACX+xgRqM=;
        b=JGnNBlC9sJkriHBD0UiDZBhMEJ879rIpIP1jRkSSnyllixX2yEuYkVeRA2Hazxg9sc
         qwrhJFkORM0u+ioUMz8V8RdCgWuy/MwDkmdVAmX782BgRFGnniEEIoB8OWTtcqgXp4h7
         rIfn3yz3zqCpind+Q6CVkuhG0MahWUZPH/rW7iYE1jQ75MtGZxyxZ5C5XraHhuapbizL
         +dvFrLXijsnB5As/rcjJrYWj+HPNwCVR+P97vExKjzSV0HzKdNcztadZbcb0C8Dz1Yed
         24BrkP1Id33507XXew9lGjnuLTLnpkX1tnRjrSAR7eXAgU41rvYL7Ll8tbl6xnnu/wq3
         7qHg==
X-Gm-Message-State: AOJu0YxU4h1myHPPCSl8QSWXQ/V5DvjRQRtLdKrAEUwZ5HMicoA6S70i
	ZA+8pfZsZNy7c1iXmt3OykvfU893RCWamjF/fsGRP9PQwnuKNLb3BdME4U9Afy1q+wI=
X-Gm-Gg: ATEYQzyGY7Ja6AARKcEWWRigGfp0bT1DKAgWjYii3pvFNQ80w4F3hZYG7bem8hB6ZUV
	N2aEgnA05NjVwUHD2HX5ZwgNB01Do9Q2hbI/OmpV5eN8pkHq1lXpuvdbvKcfo1MvvZl70jRxZzb
	nTuPEbyF0llPZGKSmU4WTQZC5E/CprfhdQ393emVZAYwZ9/s1sMFjoW7Y1OYba/BIE5Y4krUD/0
	sfUIPNjRYTBcSkHW9nTSVy8U4/eGwVW9uCcTnNJDmhcPzDxiBBID/onqazt5ghgl9YjkNuP24J/
	mr7rCELyZ10zfT8dMS+w0elD3umFdiTu3UC1xgZ7AuJQOAnte5ekLP43nL6XoXAhdKrQASyDaB6
	+KC/kKL6ne+AULAuUI1+wSTWIG5eMI1GwDl+HY2/9zedFgB8IDAHUEa3h7sP1DZPaR7aaOr2us1
	uu1s26wklgpitzeXJe359JzH20l53b+lZWA1oOS4xLSu8ctrjS8OQf7rI=
X-Received: by 2002:a05:6402:40d6:b0:665:57ca:9033 with SMTP id 4fb4d7f45d1cf-66557ca94f2mr1992718a12.28.1773671001093;
        Mon, 16 Mar 2026 07:23:21 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6639fe6dc9csm4597445a12.17.2026.03.16.07.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:23:20 -0700 (PDT)
Message-ID: <3969f887-4d3d-4fb8-870d-6af834d120e5@suse.com>
Date: Mon, 16 Mar 2026 15:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
To: Sami Tolvanen <samitolvanen@google.com>,
 Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Petr Mladek <pmladek@suse.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>
References: <20260305015237.299727-1-joe.lawrence@redhat.com>
 <20260311211207.GA2440964@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260311211207.GA2440964@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/26 10:12 PM, Sami Tolvanen wrote:
> On Wed, Mar 04, 2026 at 08:52:37PM -0500, Joe Lawrence wrote:
>> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
>> related macros") added .text and made .data, .bss, and .rodata sections
>> unconditional in the module linker script, but without an explicit
>> address like the other sections in the same file.
>>
>> When linking modules with ld.bfd -r, sections defined without an address
>> inherit the location counter, resulting in non-zero sh_addr values in
>> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
>> sections and these non-zero addresses confuse elfutils and have been
>> reported to cause segmentation faults in SystemTap [1].
>>
>> Add the 0 address specifier to all sections in module.lds, including the
>> .codetag.* sections via MOD_SEPARATE_CODETAG_SECTIONS macro.
>>
>> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
>> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
>>  include/asm-generic/codetag.lds.h |  2 +-
>>  scripts/module.lds.S              | 12 ++++++------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> v2:
>> - Update the MOD_SEPARATE_CODETAG_SECTION for .codetag.* as well [Petr]
> 
> Do we also need similar changes in any of the architecture-specific module
> linker scripts (arch/*/include/asm/module.lds.h)?

I overlooked these architecture-specific files. I believe we should do
the same for them. For instance, riscv explicitly defines the .plt, .got
and .got.plt sections, and they have misleading addresses:

$ readelf -t fs/xfs/xfs.ko
[...]
Section Headers:
  [Nr] Name
       Type              Address          Offset            Link
       Size              EntSize          Info              Align
       Flags
[...]
  [48] __versions
       PROGBITS         0000000000000000  0000000000194e90  0
       0000000000007900 0000000000000000  0                 8
       [0000000000000002]: ALLOC
  [49] .plt
       PROGBITS         0000000000007900  000000000019c790  0
       0000000000000001 0000000000000000  0                 1
       [0000000000000006]: ALLOC, EXEC
  [50] .got
       PROGBITS         0000000000007901  000000000019c791  0
       0000000000000001 0000000000000000  0                 1
       [0000000000000003]: WRITE, ALLOC
  [51] .got.plt
       PROGBITS         0000000000007902  000000000019c792  0
       0000000000000001 0000000000000000  0                 1
       [0000000000000002]: ALLOC
[...]

Nonetheless, this can be done separately. I think fixes for these files
should better go through architecture-specific trees anyway.

I can check the individual architectures and prepare the necessary
patches, unless someone else is already looking into this or wants to
take a look.

-- 
Thanks,
Petr
