Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6761A304A
	for <linux-modules@vger.kernel.org>; Thu,  9 Apr 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738240; cv=none; b=agB5UrUibw5gA8a4xbl9pxn4pMQ2B2naVVdNQhiBp3Ml8jjJv0tVeQBivYqjxvG58vdRQlWECFIsKV+ZaCbKPhnaWEHr8GJ8Cp/0Qjm226mkLeTzBQdoqQgtiNvNJyiaeZnTn22qXZNIoufBpyJBy9+4W6ilbAwe6FKWzD1UsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738240; c=relaxed/simple;
	bh=kXqVC67K7Ok0URFdMQss6lTIGbLrxnPL13nMpdUnN/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dX/ALoN84T5nvxWfCCquiANQVpX4mASwF66SYAauZpX4QM+MB4aTV7c87ASUcfEDsv8VbaPNWeLp/wxY8AuKANPGGEjNZAo4PdY7lOSi3+YRIoQeKmOnLugFYZ+55CD0hJfBPcdYRTusv/xfRlPV6qe7QvpDVEIuIrczjoUZPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SueCztIF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SueCztIF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso6932145e9.3
        for <linux-modules@vger.kernel.org>; Thu, 09 Apr 2026 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775738238; x=1776343038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXMv5P2otA71oVxzctM87KJsMKwFOqSK4K4FBNtEt2c=;
        b=SueCztIFgURyMdqUY2D5JdT1xiLTmI/DfOmKuqUjDrd2r7hrlpHxDhhSrvnzauD/Db
         gd6XWOToDf651nfNocXYFmCXeSjWtm1/Re1Kwuimr/GaBtNn5hFcjPIsAsGQC5UFemDo
         DXcEOPpGOFkj+crkWm/fpAb8KgP6izmquk/0l8LF/z4z+bWAF6p9yXDUAqFW5xyfCb8e
         QlYTEztF/CbIN8HI2K7HJBXnyiS3LBmN30ag8w4ksIpVltauPn/itCWb88qd5hCDc1lH
         EtLAvTKieQDEOYzX0KAMdhEDB3F9CdwpTFy3Ko4/nrVwS9IA0r1iocNFM8HhdcxD2Q56
         MqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738238; x=1776343038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXMv5P2otA71oVxzctM87KJsMKwFOqSK4K4FBNtEt2c=;
        b=dnGPgYcWTnqi1va3OE2HcizSvkzDrCLODnlHocayh1yZY/yMmpjeFgJVuuNa0/1lUE
         iJklcPQuovWDtN7b3j8dZ6IM6tsm5dZizPCx1STpWmO6TjPYhIRg19Lcr6pP550+Af54
         RzsaXjTvhOD4vLStRDEDbumeoLgegVxxcs84TfInAgMPADFmdL1+UX8HAjJEsc+UuRks
         Ss3sn+aUdtC6fuUeg5KIR6V1W1LoFj7zYY+eRz0KseFcHiAoPzeq2sctFVjD1VKnIBkf
         UmZn+NP1xojBg5LvU8rMiPSnLWkOJs3+AvYD2BVm3sPqcokm9E32uF9384IvTl6q74fi
         +CAg==
X-Forwarded-Encrypted: i=1; AJvYcCWXaLoAbi2SKiYgNxGBvB/8tl4kRi3aeTIJ29MDWs32gppA5VchNPalCl3CCEiehniIFgKOG6mzoOqaJa1o@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYnW2IutrrtY5qn3oSvD4i62mAphB1liD0S8+G75SSzaNeBWd
	R0ER1sbQOEv5U9WKvWm9lFwvACNi1ubBSAljxn78dgqocdpjbNe2dvLlV1fHa1NO5Fk=
X-Gm-Gg: AeBDiesmFA4VpiawCHYkZ/u6c35ZDVRd6q2Rob8GsQsAnWsfHrF01onMkmvsjUS55fi
	enZ4UrcB3OCXEp6fEsyhHg8n3NEuHb6Z4ryQhsxFQ107Nx72MYWHdvKWOcJ+dA+qd9VC6have9/
	wpgsE6SYHbxPeGOHAuWZD7jw1D8Bj/3dc0rKwGxzKKTTWtqHgRZONjT5KW9PFsNP/Vr7XeljGp7
	8k2KQ/yrNNrQCiXmcBWPLqdms6m2r6FJTglgqWSixSSt+2qgz6BHsW92EORsHdH0Ps2LN0p7smz
	p1qX6PlBxobPK+1L3XLIdqu53d8KfwZHEsel+eaAumQjgQI3WMxEKHdrD0HDjr/+Axq2Ek284IE
	yRcAxW7YjJ+i8n7HnyUPct59jYIY6/tpM/8+/aXfxT2TpOBLNHdp1/K4lQqUuZrcxCVVpxE/bW5
	NmrGUKBDo9dpTqXsrUm/b8IzwPKZ42ZhhEKxiGX54P9FaA
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr157487535e9.30.1775738238024;
        Thu, 09 Apr 2026 05:37:18 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cfa75ae2sm100719905e9.14.2026.04.09.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:37:17 -0700 (PDT)
Message-ID: <47cd7c31-c914-433c-82d8-22875c32122c@suse.com>
Date: Thu, 9 Apr 2026 14:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: preserve module tracepoint strings
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260406170944.51047-1-create0818@163.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260406170944.51047-1-create0818@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 7:09 PM, Cao Ruichuang wrote:
> tracepoint_string() is documented as exporting constant strings
> through printk_formats, including when it is used from modules.
> That currently does not work.
> 
> A small test module that calls
> tracepoint_string("tracepoint_string_test_module_string") loads
> successfully and gets a pointer back, but the string never appears
> in /sys/kernel/tracing/printk_formats. The loader only collects
> __trace_printk_fmt from modules and ignores __tracepoint_str.
> 
> Collect module __tracepoint_str entries too, copy them to stable
> tracing-managed storage like module trace_printk formats, and let
> trace_is_tracepoint_string() recognize those copied strings. This
> makes module tracepoint strings visible through printk_formats and
> keeps them accepted by the trace string safety checks.

The documentation for tracepoint_string() in include/linux/tracepoint.h
contains:

 * The @str used must be a constant string and persistent as it would not
 * make sense to show a string that no longer exists. But it is still fine
 * to be used with modules, because when modules are unloaded, if they
 * had tracepoints, the ring buffers are cleared too. As long as the string
 * does not change during the life of the module, it is fine to use
 * tracepoint_string() within a module.

The implemented approach copies all strings referenced by
__tracepoint_str and keeps them for the kernel's lifetime. I wonder if
the code could directly reference the original data and handle its
removal when the module is unloaded, or if the quoted comment should be
updated to reflect the new behavior.

-- 
Thanks,
Petr
