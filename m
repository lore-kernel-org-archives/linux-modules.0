Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91201242D9D
	for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368024; cv=none; b=df9sGsUZoazJyqnaT82QXH3IGN0GEVazwkNepePpPt1qmfnSlRpG49AyctKtrHzqIqoJfkxo1ev5bMjepMjZjYqoS8uTw91Us7Gw0DEaoIPNRTUBc5nXubqXUN3Ul7pA2aQiMUrNmBBfzSP988SGUNOo236zWpfGBEDGjIl9oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368024; c=relaxed/simple;
	bh=o+cMkXZ4AL0yvc8YxODTxfgOpONgzCRH94hoPaiSk6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQeXOJs4vDISNP0ac+cI7N/qFkNEHCc3CPIMBW7Dwc/tE072SfequGC7KKqcSyMsF6OdpJJFEcWpODGdyWPNja2X4EI1oXHG11CIfzMYXcwqnUD0h+iUlqjouojZKVVprdQaQdgyJcrlkSz4Kw/06LpMn9vnI166z2S9KvpmAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KkAkN/7n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KkAkN/7n"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so16401855e9.1
        for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774368021; x=1774972821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=KkAkN/7nZwFHSlOrMHhFIszI7EZfNiGhn2NZaPp3knF8FbvT7qhEsjnixr18ZsPQ8F
         Np694D1YOe7BoBzB06L6vrk44wLjWMWnkgXEjYUCNuk/nUAcrOazMZ/scQP6rctvOpQ8
         LlUa3xx/PjV6E1b47uLOkTh4GrxZBh25woSoYps5wJzpOkbCjEWWEtHoIFpGIpZoSFIj
         FX+VQxihc19Umdtg1EwdS+Qt0Q/v4QCIIVnV5969BwS118bpndgeKe1mzo4Y6KDlWneV
         JFTCVf11QpRpe1vcHy7jPH+oE6oAejDbwwylsLzsf9nhEs0vc51h886yPsVqpln9Xq5q
         3JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368021; x=1774972821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=lf0fzxT1xEyPLXY/SktiLCgnoL3nP22WGPtMOSO+LMccC8wPF178aBc4lZrOZ0K1RM
         bfKXBE6Om7tHJxjb65OQ95/P9PReUzYYzHNJ/SCiIIA4telnKHoVnlJpFRfFnD56GdX8
         NRkkTnkYpiiyj9Ga0fIBQnKXLj7uL9hQCtdaayqjhd8sh0BiGsEv1NprdIF787jgUkpM
         zvpwfEbnDvdO68BUvY3EUGnx+1NSgg9f1AZAzda7oX7Q74m0RnY/YXwHNSHDW+YMPFnH
         cY7QC8KTgdZtJVU4eds+CYJrNvxoqY1NETb4nDvMazSEpP16ctVXNO/PVL2MxSvISZuM
         QHiA==
X-Gm-Message-State: AOJu0Yz7AbERghXPas/DR2sJ9rHKCgjbIxRB9R7saBu+eBxtYoUU+miF
	Kgbl7Lc5PxscgVYU8gG030/CW8xbcMTereYFJeIfkR3j0oq2xtvLudQMSYCvbPtNZU4=
X-Gm-Gg: ATEYQzzmU8cblRM1aWAfi4Hwqu67wdzzvapDwHShG+eBSmGl1HCgn/dNMGU8d8ugN0u
	hogkQmGrgYc6eY4yvP6a5l8jUV+NvxQdN0PGsQcIQqjDm47dF2fzCQ88kFWrhx1mBVxIlgrRuXf
	RK7HDKeS8IKLw8NGOumrKOOYfc5cjf78rT5KuNS96RdgmyMYo97cu2mhdtlDCPNH2LnlMaSraiA
	WEPoIxpLW1WsTLkqMsTMvq4nt/e1x931FVGQX8lfpwfrFh+ws/WCNeVkH/QxmnfjcDNxUZaJRPI
	vrZCXwNWBh8NxO32TjLGTJviPSFp4XcF01aD6QTrms9wIcBcRKqwi+noU8XOIt4wKMjj78ZiSyy
	KD6rG0fNl9mcaYAS1z+DnsEsWQ1MvoXBb2CKZKC797VQWl5MqPplS7c8rI6E7ZYEhbCbEPvc+dF
	BMvJrkcGeOcL38y439zffgLK3byZk4SPcHDv2zVU2l7l3h
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-487160881a5mr4153985e9.31.1774368020765;
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113c4eb3sm68147455e9.0.2026.03.24.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Message-ID: <282574df-7689-4677-929b-b844e7201bd5@suse.com>
Date: Tue, 24 Mar 2026 17:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/kallsyms: sort function symbols and use binary
 search
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260317110423.45481-1-stf_xl@wp.pl>
 <b6030f42-b4d2-4e52-acec-76e25c0f40db@suse.com>
 <20260324125304.GA15972@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260324125304.GA15972@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 1:53 PM, Stanislaw Gruszka wrote:
> Hi,
> 
> On Mon, Mar 23, 2026 at 02:06:43PM +0100, Petr Pavlu wrote:
>> On 3/17/26 12:04 PM, Stanislaw Gruszka wrote:
>>> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
>>> over the entire symtab when resolving an address. The number of symbols
>>> in module symtabs has grown over the years, largely due to additional
>>> metadata in non-standard sections, making this lookup very slow.
>>>
>>> Improve this by separating function symbols during module load, placing
>>> them at the beginning of the symtab, sorting them by address, and using
>>> binary search when resolving addresses in module text.
>>
>> Doesn't considering only function symbols break the expected behavior
>> with CONFIG_KALLSYMS_ALL=y. For instance, when using kdb, is it still
>> able to see all symbols in a module? The module loader should be remain
>> consistent with the main kallsyms code regarding which symbols can be
>> looked up.
> 
> We already have a CONFIG_KALLSYMS_ALL=y inconsistency between kernel and 
> module symbol lookup, independent of this patch. find_kallsyms_symbol()
> restricts the search to MOD_TEXT (or MOD_INIT_TEXT) address ranges, so
> it cannot resolve data or rodata symbols.

My understanding is that find_kallsyms_symbol() can identify all symbols
in a module by their addresses. However, the issue I see with
MOD_TEXT/MOD_INIT_TEXT is that the function may incorrectly calculate
the size of symbols that are not within these ranges, which is a bug
that should be fixed.

A test using kdb confirms that non-text symbols can be found by their
addresses. The following shows the current behavior with 7.0-rc5 when
printing a module parameter in mlx4_en:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1209f20 0000000100000003   ........
0xffffffffc1209f28 ffffffffc0fbf07c [mlx4_core]num_vfs_argc  
0xffffffffc1209f30 ffffffff8844bba0 param_ops_byte  
0xffffffffc1209f38 ffffffffc0fbf080 [mlx4_core]num_vfs  
0xffffffffc1209f40 000000785f69736d   msi_x...
0xffffffffc1209f48 656c5f6775626564   debug_le
0xffffffffc1209f50 00000000006c6576   vel.....
0xffffffffc1209f58 0000000000000000   ........

.. and the behavior with the proposed patch:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1077f20 0000000100000003   ........
0xffffffffc1077f28 ffffffffc104707c   |p......
0xffffffffc1077f30 ffffffffb4a4bba0 param_ops_byte  
0xffffffffc1077f38 ffffffffc1047080   .p......
0xffffffffc1077f40 000000785f69736d   msi_x...
0xffffffffc1077f48 656c5f6775626564   debug_le
0xffffffffc1077f50 00000000006c6576   vel.....
0xffffffffc1077f58 0000000000000000   ........

-- 
Thanks,
Petr
