Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658A23183C
	for <linux-modules@vger.kernel.org>; Mon, 23 Mar 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271207; cv=none; b=TBpeG9JPJyX3ZiVIoe2K9oOaHxxHkQ6dUFSw0JBG7522bl9a1YkeNIJZ2V3VwZOaEQ2balLUtTUwPt7FNX1CrsN8MqTnLzqtjhduYVI4zybx4339MH6uWN7TADuqKrWUmx7W4Ou/WYL5zgGgQPA2mR0v+bmxMmY71FuK2PWF/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271207; c=relaxed/simple;
	bh=MyPj7IilmsOkQbPJ0UsoFWuSk6o+6Jy+Fsm+s2cZ70g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOp+77kt+aq0Tsul75NUkxRKJ/8J4kowdjMUr8ljEUF5OJ64g9Z6tIkzsHqh3vDnyv54P5MWRDPTBeklDA0QWw5QM/zGz71CRzy6F0Ml6hkgBAgyokJavL+4hWw7hMfv2HmIKsjN+EljusrzCUXIHlobKyEOWp9D8ltyVzX6Xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWoWw0kO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWoWw0kO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso723435e9.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Mar 2026 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774271205; x=1774876005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3gKprxO6kW+gnEONjHAGOtiSkxzFKPQeFPHkZURXxg=;
        b=CWoWw0kO4+wgMLumIHjt9NUjfOlw2QY5IUVwapeASjcM9zW/eyuwoREsXV7f41TZ0P
         fCIMy5QKc77hZLJ7/uwIDhNO/hKo/4nOfQU7hRzhNz8wB6JEBcbwVeDdkN6it/fRuwqN
         IzfMUhc+hCs+lHE6pB+LpnhXSOJHVmO0ePz2xMgq/WgvqMuWkF/+OTxw/0I3lp8xjBZi
         dtzMg+JlZaMf7zXFHIuG3KLQ4hwgh9zlCXP/bRa8Vdr2N256JLyn7dccy8YAHjT5Q0h0
         xwRhvw8mR2WC6zD6zIz+1PufXGV8xRTTyJVMt8s+XkPBdtJwwSkuwlXovOBTy83El7Do
         1Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271205; x=1774876005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3gKprxO6kW+gnEONjHAGOtiSkxzFKPQeFPHkZURXxg=;
        b=AnYF5383r5iR9LBifAfKG5b45cza1HxrMSyY5BNzQ8sKV0WD8kWzvS18Uu3Sfn4WNO
         7d+WB1Y2H18p6SMsoaHoXKqsvjNew//EoXz7zrub/6+xJmjbnpWTigWH88tA6sh3SWtQ
         gI4DWz5bWPOd6dbMk3hm4lA/r7lz2uVsgOEOzNEBivQVY3GTxDh/4ax0ygv1eqpB1N+7
         QIxlMWyToR5Ppl1J8ELtKV7Jb2whnlnWTpYa4Ep4ZPjLh7RMUCBgIU7pm2RD7n8GVQqP
         I4ou0Y0XDuIihxUwFUJFpoaviWOHolcHJHiPGvFIm0HrkcLQX12l39paLiW/ixcz1Tqg
         dLeA==
X-Gm-Message-State: AOJu0Yxr+9UwHXR7/tL+0GohX7NL04JJaeJeYursnOwZYCFTwG8cPZdC
	RPHD0lzc/LojdQTD36E9cguBgb6FKfI4rC/yBOkoStr06sIqFBV232aTyvQt3tjiQmQ=
X-Gm-Gg: ATEYQzzVpTOjJ9Av5kosH9HuHbDPXuXCCibFzMpmhGu0AEoMZ8To4j5c0L8cKSa7znu
	y10a7EGVmPONzqEGtD4oDSrRBybXj1GDvMEVYcBvlSTTk27POPzqMDBMgI381+eQXoBRB9fr5oV
	ZSVMpFSlc4nfBaU0A4aR8QOYsGBcHp0MyczxfhuYVc7h46/Vv6uSjwa5wWh7NfBtsYNYF7wQYLA
	BUXJEu7j+g8sHrJgVH2kzZLgordbrlGYb+L2Ustz75yzR7tlcJOCVFTlMG5TpHLzZ9KM8ZRojkL
	miT1W+kwteNMQ9EIZGpHT+a3+ql9fqOiHmuzNwOhP+NCZNfDpaQoUj2gI2O7Uq70hbc2wRgShQK
	0uHfXuesoJvBEl4aw7UU3wC5h/Eg4nTKiVa00cqu9oy6HjYUAVzf8G3O5ehy+XAG9ekisxYlyo2
	t611AGloS7jPqDLFUup6QUoC/QgeG0wKZV7BZGHzKGTphG
X-Received: by 2002:a05:600c:3b07:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-486fedab4bdmr170699615e9.7.1774271204664;
        Mon, 23 Mar 2026 06:06:44 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1c16absm79866135e9.26.2026.03.23.06.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 06:06:44 -0700 (PDT)
Message-ID: <b6030f42-b4d2-4e52-acec-76e25c0f40db@suse.com>
Date: Mon, 23 Mar 2026 14:06:43 +0100
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260317110423.45481-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 12:04 PM, Stanislaw Gruszka wrote:
> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
> over the entire symtab when resolving an address. The number of symbols
> in module symtabs has grown over the years, largely due to additional
> metadata in non-standard sections, making this lookup very slow.
> 
> Improve this by separating function symbols during module load, placing
> them at the beginning of the symtab, sorting them by address, and using
> binary search when resolving addresses in module text.

Doesn't considering only function symbols break the expected behavior
with CONFIG_KALLSYMS_ALL=y. For instance, when using kdb, is it still
able to see all symbols in a module? The module loader should be remain
consistent with the main kallsyms code regarding which symbols can be
looked up.

> 
> This also should improve times for linear symbol name lookups, as valid
> function symbols are now located at the beginning of the symtab.
> 
> The cost of sorting is small relative to module load time. In repeated
> module load tests [1], depending on .config options, this change
> increases load time between 2% and 4%. With cold caches, the difference
> is not measurable, as memory access latency dominates.
> 
> The sorting theoretically could be done in compile time, but much more
> complicated as we would have to simulate kernel addresses resolution
> for symbols, and then correct relocation entries. That would be risky
> if get out of sync.
> 
> The improvement can be observed when listing ftrace filter functions:
> 
> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> 74908
> 
> real	0m1.315s
> user	0m0.000s
> sys	0m1.312s
> 
> After:
> 
> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> 74911
> 
> real	0m0.167s
> user	0m0.004s
> sys	0m0.175s
> 
> (there are three more symbols introduced by the patch)

This looks as a reasonable improvement.

> 
> For livepatch modules, the symtab layout is preserved and the existing
> linear search is used. For this case, it should be possible to keep
> the original ELF symtab instead of copying it 1:1, but that is outside
> the scope of this patch.

Livepatch modules are already handled specially by the kallsyms module
code so excluding them from this optimization is probably ok.

However, it might be worth revisiting this exception. I believe that
livepatch support requires the original symbol table for relocations to
remain usable. It might make sense to investigate whether updating the
relocation data with the adjusted symbol indexes would be sensible.

-- 
Thanks,
Petr
