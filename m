Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B330F923
	for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016683; cv=none; b=bxNbBvlyBtEPxpoptRR2MeYHBD1y9uISnia9XdU86wPZ0g1AW91r5Mz6pLRRmmSF9fxbIqnoJeQzLaaFdqYY9vNDvBGsNZojwuVgYx5yq1UViek9zTWrBgKRtm2gLi+kYt0SlozJqJ8FgHKVXrP5rqmijuHH8edqy/NrBrfN6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016683; c=relaxed/simple;
	bh=j0ql+LLrN7jQTJFQ7N3G8EHrgQ1tyYV4vua6CPmTAPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSnD4zPAJgKhYWV+hmjc2PY7t/y+rY3MZDO2payBjcniDSA6QvHy2457gi9ZLk4Q7fAENM2cqVGdanjZoqKjrS+6moQ6Vg8kkoKdwr0DXymQYs+8kLSzvn0DzAynzXesboDbYGxaiRufo0ECVclHi7Zfd7/SWnGhfJ+zdQEXijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TO94Wtm9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TO94Wtm9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477aa218f20so54382315e9.0
        for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767016680; x=1767621480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/woNRG27/M9OqSwR5nyZqJ4xx+CHB7YoyhXgMBzHdQQ=;
        b=TO94Wtm9jQ60DLWymSc9fAvWps8dNADHTfPptNHbSvsAZVRpzhhdybiE0epjJFbuNQ
         7of6cyXnSzfscoiciJFWF8mAMOsH8OTFbs5kiSTb5/P7vVjsBGKrlrwK9fV9DrWaNWsv
         3ZRbhNmwuypquWqW3s1YpyYdRT6q+T5bSJlv5dLbMUt87bkobnTdKj1fN1w+jWiD01O2
         15j0QHq2Q5kvuZ/G50cs4H+ffvNJVJFfgMey/HZmYypIqUrjVD3BB2bdC7VigAkQU1Y9
         TfXXnYJNZyece6ZRfB4SXusVk11+KNpNim+WvehSaYglIuWiDFo0CpYMrj85mY78u4Pj
         E48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767016680; x=1767621480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/woNRG27/M9OqSwR5nyZqJ4xx+CHB7YoyhXgMBzHdQQ=;
        b=kBl+/4bnl5dnoZuq6QPRnYNUKXO5DRMW02mCA/LiK0RSRIeLr/KhC1QUALZqEqHDuv
         q9MO7UaZdv4Yw4H2WnrrEQ2fbmMXHXS4+4BGoFqQqqvvS2YW/QsA1qpyfXDzS2+fAzfu
         ga+TSJqOKFwz5zaXwe7Zjsd37epYmDbBrOYJgPy4UIxlwjQAqvIwKUTqdgfgnkWu5WEJ
         Ep9slGj6R9NW8xotRPOTfafXbj0bS5hZ9JP9fY1a4TduPFEn3TYM/Q9IGP2jTXiYMAUc
         WmiHOYuNCa0CvWmgi5V5dO5kKBI0WaTOupPZVEmaGk05T0yt6DIy5kI3rihGOcaTID5n
         n5vg==
X-Forwarded-Encrypted: i=1; AJvYcCWEf7s+3T03xc2yl1FBYlHG/ZRlJo3JpmiQTqAYZaDpklIQPPEMFMq5PNulVnI9sCp1pvM0aMYem5cv3m3T@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHX25CODL44XoWfMGC7FAwg9Vt7aHqar8PRmXE4X0od+ddsIB
	3/ANlabHb3pG93VJDZOejq3s6KbVK8kLLJm9z7Q0cPLpUZiFAsfP70WXNMthFw2FhmQ=
X-Gm-Gg: AY/fxX607KpwjDI8Bn6BKRcDKRD27uBBs5ngNRkCIDOp+IHDx7XHS9BhVf0ksOQzSmI
	AoonCkPs0cQt20y8MEfYK3ZTO/83XjAaFO7Wj5vcA2NrMJ0DgHTJyW61AP8ThdNz++AXZZlUL5Q
	9tuz1bDeqgbCmrIqNEnpB+96egtrac0bqUMgN33TJ2v0T4O+uvQZ0pAIH+sawmAUS0sTSFFSBN6
	wis3j/hAIIPNJz+vF4bpVCqi9NE8qgZitcJqBdjOnHTU8jTx5hp0psyGxNLJpxDqWjyWr5iug5n
	KL7oGhgs8AaSV20z/VYmR1S9GLVyYcSRvgRWN5bZbxv3tg49fYbs0M4T5oHG9WpD8w5qgrP6rm0
	cdvrjwOjogGLyM1qS2oh8RE9ec/S+vEfi5ylumReum/F2CZH4cFsU46hK6qmr6y9e4US5VKQ/Fg
	psg4v1XY37vxhBHO+SOIAOW7iUnTeNTSdX5+cqL6xEBlqz7GLegVE0PbXVBYbiJQFgVZyx72wjt
	XmhMqNwxMJqX4WzgfQ9y6JDm8a/4swwDxCveqosPgDrXXg/PgjGetT1nA==
X-Google-Smtp-Source: AGHT+IGE+aL517vflAEyDwa8ypSMQBSclRIeWpinNU4iYkWIpdq9jBGULPEiQ+tTI6H7zOP/V1wJNw==
X-Received: by 2002:a05:600c:c494:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d19582aacmr353941545e9.30.1767016679859;
        Mon, 29 Dec 2025 05:57:59 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2a94sm63125099f8f.43.2025.12.29.05.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:57:59 -0800 (PST)
Message-ID: <04363c51-8887-4a9b-b2f8-a55edeb6f727@suse.com>
Date: Mon, 29 Dec 2025 14:57:59 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /proc/modules address+size bounds are inconsistent
To: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org,
 Sami Tolvanen <samitolvanen@google.com>, song@kernel.org,
 linux-modules@vger.kernel.org
References: <CANqewP0+N0i8Ld+fGKQZbLg5yJhVkLTyvZKz_ZL0aV+noArsiQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CANqewP0+N0i8Ld+fGKQZbLg5yJhVkLTyvZKz_ZL0aV+noArsiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/25 1:52 PM, Tatsuyuki Ishi wrote:
> Hi,
> 
> I noticed that /proc/modules reports inconsistent address and size
> values for modules. In m_show():
> 
>      size = module_total_size(mod);              // .text + .rodata +
> .data + ...
>      value = mod->mem[MOD_TEXT].base;            // only text base
> 
> Looking at kallsyms, .data symbols can come before .text symbols, so
> [addr, addr+size) is useless as a bound and can be overlapping.
> 
> I have a userspace frontend for perf [1] and the code currently
> expects non-overlapping regions. I can add a workaround to truncate
> any overlapping regions from /proc/modules. But is it possible to
> "fix" the kernel-side semantics here?
> 
> [1]: https://github.com/mstange/samply/pull/736

The initial code to show the module start address in /proc/modules was
added in 2003 by "[PATCH] Module state and address in /proc/modules."
[1].

I'm not entirely sure if the intention at that time was for the address
and (already present) size read from /proc/modules to provide a range
where the module is loaded. In particular, if a module had a separate
init region and was still in the process of being loaded, the size would
also include a non-zero value of mod->init_size, which means this could
result in overlapping ranges.

Nonetheless, I assume that providing a range was indeed the intention,
as I don't see how having just the address of a module would be
particularly useful.

The patch mentions that the module address was added for use by OProfile
and ksymoops. The OProfile code reads /proc/modules in the function
_record_module_info() [2] and appears to expect that the address and
size form a valid range. The old ksymoops code [3] reads the file in the
function read_lsmod() but doesn't seem to handle the added address.

More importantly, I notice that perf has the function modules__parse()
[4], which reads the /proc/modules data and is called in several places.
For instance, the machine__create_module() callback [5] then expects
that the address and size form a valid range.

The original behavior was first broken in 2022 by commit 01dc0386efb7
("module: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC"), which
introduced a third optional module region. A year later, commit
ac3b43283923 ("module: replace module_layout with module_memory")
further split the module into up to seven separate regions.

The separation of module regions was done for good reasons and should
not be reverted.

Instead, a simple and consistent approach could be for /proc/modules to
report only the size of MOD_TEXT, or to show it in an additional column.
I suspect this should be sufficient for debugging tools. However, this
requires careful checking to ensure that nothing else breaks. If more
accurate or complete information is necessary, the kernel could export
data about all module regions under something like
/sys/module/<modname>/segments/<segname>.

[1] https://lore.kernel.org/all/20030114025452.563462C374@lists.samba.org/
[2] https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/libperf_events/operf_utils.cpp#l1327
[3] https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/ksymoops-2.4.11.tar.gz
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/symbol.c?h=v6.19-rc3#n668
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/machine.c?h=v6.19-rc3#n1467

-- 
Cheers,
Petr
