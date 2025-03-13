Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2D1E493
	for <linux-modules@vger.kernel.org>; Thu, 13 Mar 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853841; cv=none; b=jflexFZAURN0PAn/LIzk1aGNGoNNKGBWEmxkl8GlD+4o5dhuueqxSWf/Dyq6w6k6M61eeId7b6OdhNAItcu5KsqY8aPZfoLfeWx9jswC5P5ovcy8PQdXM3O3lNRXQ69I4dotWFrIxrOVSIlXfu1bx3pGOC9B3w7PxgT4m3uHONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853841; c=relaxed/simple;
	bh=dgyBTKsI+bB0OKWM0EaP7qWti7HjeYx6dVbpYAIUWJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQBXmFlTeoxQR/lc+pQWFQz96/BEB7x5iTGMNAm59pMdDX37EXLXs8XkKpGAtNI+6uYN3ZvIFSzxsBtakG112+RIIIo/aVW5UpAMEEiZVEnnuonElqFjLJyvCGxCxa3J7zLc98C9Viktd5u5vVo5fEZTreXA97rXBjU7bEotjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUuLJH6P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUuLJH6P"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912c09be7dso377591f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 13 Mar 2025 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741853835; x=1742458635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5VGHsIHk2eDWQ4Rw62qVaWVCnpCrvunnZzyL/N6scw=;
        b=JUuLJH6PrFqBSZluQTr+Cv2lzWnBbZixMeR4f9x7AYreVSj/+YlbDz/C6hQElX/ZFD
         f+GsSwzjTgOuF5JJBU0HNGrrsg0IFnUc1yvpZVAW0TX4QgdnjFv1VczugKL6HEsLrs5x
         qMeNTXxpiA1/xpsKQ3SPqsUj4pUSDUUozXOj/6IIwxuvvQVnb5uxYfDPS9nQaQHyvvkk
         e1PgjSpFd68sXteABboPzmm2bqvgmkpXTD2SxBfR5vAp56BLjRXJdY1t2w625A2ERXOX
         1Bp0ij6/emm50nPBxjfJMnFrelpWahFvzo1xgY8N2BYIX4NNAlw3LD7D6+dEl15kJ+wS
         Y8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853835; x=1742458635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5VGHsIHk2eDWQ4Rw62qVaWVCnpCrvunnZzyL/N6scw=;
        b=aA0pTBfaoSklr+NBI/ZiF6AlcadpZaPFvS9dxt1Xf/zY1wzcg9R/ETu7MV3zq2tpgg
         xSLxTinq8bB5cK7d4nbsugqVANPez7Zwbet/H1CskBif3r6tQsIcXU/LoH+U4kdw9epI
         GVM9EDYcpbV7kyB4rLoJq949VRV0Gvk9/ibDDbDVdjpdJsNosvTyp6HSFDxJ0Ku5f2MZ
         uLJGC0FMWkQhZIxyUFe5Pi8c2QqORrXnLsZdntdKPudvuY7pHOv9WQcGJH0hpdLBuR+r
         oSf4YvH6ZROwe0ayjwP3v+AzcwoWiqllOgncIUM/VRSJOwxQKwFa1jOLS7iAFD5KfB4u
         ZcUg==
X-Forwarded-Encrypted: i=1; AJvYcCVeanp8+GjtqWcU1c7E4du56DIGAMjkzM3xAUvKSlkzR0o5yDlyflSom8T+q42qXIemnf30AFQRBxSMfq4O@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFa9ef8cnNC3GSzK5BM6Vy2unQq0afMUgDNZKDdGsBAte5mXH
	NAutea8lkq72n2zE5t5zbuf6SywSI2d7ao+97KbA25ItiC9WPHP0n+MiuugYJ5E=
X-Gm-Gg: ASbGncs+UGwxT5hgRBBngljSL08OEcbIDTMxGPSCZdbuXTcqMBXnsVPAEeRzPkfi4AL
	Q6AfJofncgwfGaYFUVDneS5PE5wKVJ4hnMPIIA4Lq6EaWM0d9kSk6zgp41TNbUSQFrq9ALtT/N+
	XJ9gtyWcKJoQQl45iqFKt4+Wc3/m8X2bXjbEmRoZcQ28I3ODidwHK8Z1jih0FQW8xWSvzMitUSp
	cZTCjex3an5EEXLI1KIVuFaPcmyPXO8yJPvjOBbS7pIKKZHUdyShD0TGzEbUEgfzolS+n04BUkQ
	G2NM03b9G7bJf16petyxWbmaNrCSCOmoxGpiT+w66a1f9B1Q
X-Google-Smtp-Source: AGHT+IHXRGv+qFJBjsVPj4BxsO5Tnkhc9lyYOb66yOTrVrPqTSzu342/y05U44Iy+nKr102NIVINaA==
X-Received: by 2002:a05:6000:2ac:b0:390:f460:77b0 with SMTP id ffacd0b85a97d-39132d3805cmr19978214f8f.26.1741853835019;
        Thu, 13 Mar 2025 01:17:15 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm1257979f8f.70.2025.03.13.01.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:17:14 -0700 (PDT)
Message-ID: <31f49892-a9fb-407d-b266-6fd49e3c2bbe@suse.com>
Date: Thu, 13 Mar 2025 09:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Daniel Gomez <da.gomez@samsung.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
 <20250307001256.GA2276503@google.com>
 <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
 <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/25 00:21, Sami Tolvanen wrote:
> Hi Petr,
> 
> On Wed, Mar 12, 2025 at 5:05 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 3/7/25 01:12, Sami Tolvanen wrote:
>>> On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
>>>> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
>>>>> Section .static_call_sites holds data structures that need to be sorted and
>>>>> processed only at module load time. This initial processing happens in
>>>>> static_call_add_module(), which is invoked as a callback to the
>>>>> MODULE_STATE_COMING notification from prepare_coming_module().
>>>>>
>>>>> The section is never modified afterwards. Make it therefore read-only after
>>>>> module initialization to avoid any (non-)accidental modifications.
>>>>
>>>> Maybe this suggestion is stupid, I didn't investigate the feasability but:
>>>> why don't we group everything that is ro_after_init in a single section just
>>>> like we do in vmlinux ? That would avoid having to add every new possible
>>>> section in the C code.
>>>>
>>>> Like we have in asm-generic/vmlinux.lds.h:
>>>>
>>>> #define RO_AFTER_INIT_DATA                                           \
>>>>      . = ALIGN(8);                                                   \
>>>>      __start_ro_after_init = .;                                      \
>>>>      *(.data..ro_after_init)                                         \
>>>>      JUMP_TABLE_DATA                                                 \
>>>>      STATIC_CALL_DATA                                                \
>>>>      __end_ro_after_init = .;
>>>
>>> I like this idea. Grouping the sections in the module linker script
>>> feels cleaner than having an array of section names in the code. To be
>>> fair, I think this code predates v5.10, where scripts/module.lds.S was
>>> first added.
>>
>> I agree in principle. I like that the information about ro_after_init
>> sections for vmlinux and modules would be in the same source form, in
>> linker scripts. This could eventually allow us to share the definition
>> of ro_after_init sections between vmlinux and modules.
>>
>> The problem is however how to find the location of the __jump_table and
>> static_call_sites data. In vmlinux, as a final binary, they are
>> annotated with start and end symbols. In modules, as relocatable files,
>> the approach is to rely on them being separate sections, see function
>> find_module_sections().
>>
>> I could add start+end symbols for __jump_table and static_call_sites
>> data in scripts/module.lds.S and use them by the module loader, but this
>> would create an inconsistency in how various data is looked up.
> 
> That's a fair point. Perhaps it makes sense to keep these sections
> separate for consistency, and look into cleaning this up later if
> needed.
> 
>> Another problem is that I can't find a way to tell the linker to add these
>> symbols only if the specific data is actually present.
> 
> You can use the preprocessor to add the symbols only if the relevant
> kernel config is present, similarly to how STATIC_CALL_DATA is defined
> in include/asm-generic/vmlinux.lds.h.

Right, that works but only statically. Let's say I update module.lds.S
to:

SECTIONS {
	[...]

	.data..ro_after_init {
		*(.data..ro_after_init)
		__start___jump_table = .;
		*(__jump_table)
		__end___jump_table = .;
#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
		__start_static_call_sites = .;
		*(.static_call_sites)
		__end_static_call_sites = .;
#endif
	}
}

What I had in mind is that you can configure the kernel with
CONFIG_HAVE_STATIC_CALL_INLINE, but some modules might not contain any
static calls and so wouldn't have a .static_call_sites section. When
using the above script, such modules would still end up with unnecessary
symbols __start_static_call_sites and __end_static_call_sites defining
an empty range. Worse, if the module doesn't contain any ro_after_init
data, the added symbols would force the linker to create an empty
.data..ro_after_init section.

> 
> In any case, the code looks correct to me. For the series:
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

-- 
Thanks,
Petr
