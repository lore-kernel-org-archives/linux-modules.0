Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC233C1AD
	for <linux-modules@vger.kernel.org>; Tue, 18 Aug 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054400; cv=none; b=K1GYiyuOckMET8Kya6a0S37aUfwF5OZiSXVjUETJK0lD4qHhf/pB/dWBuUaGS9NFR7R+H1Y7CWAOxs6wBz93+Umz2Rgk16x5BHInETMI6Xorl/F6E8DCXzmTrp034GebU1vIcUAA0y5m1qpujWu8UIDbk7voWLZPYy3GCHjJKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054400; c=relaxed/simple;
	bh=4XrU5DOs80iqMiB8KU7Viwwf3z4yaHMHf4dvuHwXlRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT8ni9Hx5buyx2NxzSynAhtmfL6U+jVldvTOWUcWBJVJde2KnhlR/qnKztnrQuhkuMEusXewRvkt6B4TKr8qRurpYUd4dILUnBip+6NVNUjn1tXOxjzYk+enBIIgjYu5TGJHtuDZpKQ0Jgzh96qjlLQHuTrLWd/nWWvY+O6zvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HiLZefeN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HiLZefeN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fe89fb333so2749374f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 18 Aug 2026 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787054396; x=1787659196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS9zOAi5LfeCdiC/XsclJmrpHRK7bC0G5EuVG3u99Qk=;
        b=HiLZefeNtIcSHGiyMMME9aqi0/V0e04QxE/ja4EXcVouytWkKgTypLTNe//85JlwGV
         Txid3tA+dzCflJRWB2cQD6w9sL4x6hxURuZM55/cRH4g28RfAwxSa2WeXmrbfPdOItr8
         8dUpotV/y34+GLch1keE3sZpfrmUNEHth/V0LI8B3t/8wOkcYsK6LTcGsRMNDJ9qPC4e
         MJzx/UyPzYhVSt9050jbYG+epYkXbXIyh+XoSp9O8l+/PqLaz/QKM9hjPCy50NBSGMUW
         nfEy8/+Zx/D58g0oxdjvPs5Ar/rY2JqbTX8cdaNuR/9bWkU+5+nt4LPGiZRhYVGbs0pf
         Ibnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054396; x=1787659196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uS9zOAi5LfeCdiC/XsclJmrpHRK7bC0G5EuVG3u99Qk=;
        b=FFmUe8RQHcbPKLEmr0+gA91R1GzS307CR5VkMYCuVPBMifyI4+/nUqKwQTk2/3t5xi
         f9JxDJ4YElKBBxv0V6TvR44DgYx9BLB7AtTzeL8ezNe8Qnd6/oURaxhhqu7b6vdt+AED
         lgUmQAFJvMejvZWL5AYI/ge88wNNg/PyOAVb9JlpyhH7ewD6Ihnk2ja+Q968/n6QAB+A
         TcXNz0MrM5BmdGD13sAD1tKlUaGdB0wm4PiqpPbR9pJdZBlfJqWMrx7qF0rcN6T2UoXE
         91G/nbtvtirQoACbbT9FiYrMZ6qd11RD9hYSvJsf0eASsLzQq7A90oDGShKGBr5+E9vX
         6w8A==
X-Forwarded-Encrypted: i=1; AHgh+RoOJPxvK8T0eUMfl8prSLLsFJovp6/7LTf/aoQa/+G9gQ/5zd6y35MHDTXT2ugmVzLC3U5ZW8vNV7xFzpDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVZHF2HRpk4XL/kidFe7OJ7gvEQsAiHmSNMxFfGUo34yoeZcL
	RqtOnFyCgg/tyvj5mGgU3EZgoBD9xAxVoscOG7RmS6QMpdnce1MsCIYetTVlGlGtyugnvF+tx6v
	q1sqlFjk=
X-Gm-Gg: AR+sD13Ud8vqB1SB8KGu52blkAdO9V1n9lePtTdfb02iIMICg4QbsuRLhTz2Axn7nL3
	5C05B3Ba3z3R8Gk4OL8BgdNodH9sGMHs7IJYNQrUKeIZA0YfNZZjgi/J0depeTzbpVyQWLYCSLA
	Dn1wo86YfJpMDc0W6VNwHLzqOuQF5vA7Dykjo+ZGzBH24XmTphAbgGExlXF9FPF/IGYoTycPdUG
	xnM+nemBPX4At20xKriOcGmq2yhl8B0GlD7jNmu/UKwisnxjFQYd7QnMP4aS+IMQ3Cb+N6WKDs4
	42uT8LIus793ly59WBWF034dlBL4tvHR+S9hhaubIeRxnZQ8bhU2qWchWchy4Ql9kkuDvpgKGvD
	m8w7T0VZMOeb9mOkt/m2aZTk4BHzzaZeNSNd5Xpe/9dJZqMPBekTguHuWUd5VVtbY4VWGIPbgV0
	zhZf81wAo8G+n8T+8TBYYs0T0zds61ieS9Ei2m+6KwiXYmamHF0xrVUUWvG03jFLWsl0cjTQMFS
	nVvqvkuyzRfEyzLGitoS/+1
X-Received: by 2002:a05:6000:46d4:b0:481:f33d:6445 with SMTP id ffacd0b85a97d-482a907b955mr9315513f8f.7.1787054395935;
        Tue, 18 Aug 2026 04:59:55 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c603sm12401112f8f.21.2026.08.18.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:59:55 -0700 (PDT)
Message-ID: <4e351b13-1670-4813-ac98-e44c00703601@suse.com>
Date: Tue, 18 Aug 2026 13:59:55 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping
 symbols during module load
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-4-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260812032807.15034-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 5:28 AM, Tiezhu Yang wrote:
> The compiler toolchains generate local and mapping symbols on certain
> architectures like LoongArch for optimizations and relocations.

Nit: "local" -> "local label".

> 
> While the symbols are already filtered out during runtime lookups via
> find_kallsyms_symbol(), they still leak into /proc/kallsyms for loaded
> modules because layout_symtab() and add_kallsyms() do not filter them
> during load time.
> 
> Consequently, tracing tools like bpftrace (which do not perform internal
> filtering, unlike perf) resolve identical addresses into confusing local
> labels instead of actual clear C function names.
> 
> Fix this by integrating the is_local_mapping_symbol() check directly into
> the newly introduced is_kept_symbol() helper. This ensures these unneeded
> symbols are stripped during module load time, keeping /proc/kallsyms clean
> and resulting in accurate call stacks.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
