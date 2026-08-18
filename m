Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064C440A3C
	for <linux-modules@vger.kernel.org>; Tue, 18 Aug 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054338; cv=none; b=hDMNFwRsg0ymMjDOi2bZVp672j1SvU4uLn0jqJLSFYgv11HSzn8/Bqi7BSYXPfQPILWBxoPIV9FNJjt/lESERFMMsEbCWQ7B056juiP1epCPMTA5buNBu2v20RNotIYVLKP3zayh5e0yunqIBrrsxeP3EhMRDxcU+g1aZxcVQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054338; c=relaxed/simple;
	bh=cBsjwGnq7m3PBpDVHoEIoFuskUMz6L3TJJljzXNosc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBHmdeac1fZwGwVZAiI8DVXP2HR6/nhiUtLNhX46FBySFzQHjvslcphurERctaUTpdFhNjFA5km3o7k6FK7ZDWZgZ4Rq5gCZ9MrgoYedMAZ+5S5jUaJ8TpCqC4QDHEED6SSBZ3deA+6ScB7tqC0VgCz/cZdGwLurHMrLkOj9pAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f4cc47Sp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f4cc47Sp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998e0916faso25764025e9.2
        for <linux-modules@vger.kernel.org>; Tue, 18 Aug 2026 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787054335; x=1787659135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bP85D3OmgxN7hDQ/WBox4fmJQt7qI0HEkQthONdkZ30=;
        b=f4cc47SpR3C8jmGrjAmwOKOPX85UYCCc+Fy56LA8BcfN8qQcpWjaF7CUo58eBgzGgP
         i64SZdXPGh554eNplRP0MAS/bdv6P5LuTHtIs06RZC/6Ug2nOSF+vk9MBbVxGuS+LmNH
         ruCQbTv5JNufooA/mebIE0qKzWMoX4g3g85zw5F+ioLNsqjTPFsK64Vdpl3iWl1kN1Vj
         lenvPERYTBfDin3u28UZNHKD7f84SHH52kBJ7j+fjbjjywcMVQhdb0J+jx7Jvql8uDKW
         tCckAehrlw/peD+XvweYupzotRDAqaa69h+ZkIRF3Qfe6LRqTyRTY86tXuwezenRYysq
         up1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054335; x=1787659135;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bP85D3OmgxN7hDQ/WBox4fmJQt7qI0HEkQthONdkZ30=;
        b=RHI59L9GZ0Eas0n/3GIKg/RuGkHE5zM+BWxFyQ5WMik02tvgUJVGjXamVXKDIOq/98
         VfKmYtO2VJ3jVV73y6kHH/MTczo3Gtn42ZfzB/wFX5XZV6ucQRqYeCxv4UiynFnn0mYE
         ocFHdfJ6A/hMVEBqB0cijagPxyBfkrsi9fV+YuxS0irp9k4vQGubTDvfUJA9PyMcnOtE
         Xj3i4YXoNQcEusvwFrfpCZwPfzoO6wklMR0Sji+LJDRCZDybmW1AiOPq0fzljQSwiMnN
         8f2a504c2uce4bGf2aD7+94L8+qgTDBsjy1CTNKkF1YzGggsgJQfvGH9bM8Q0kXrW73u
         7imQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro29VoLMc0/4ohv3Uz/iKPRyDERW1awN7PJO84hKNpPtqOpWpUimB3IXubfq5Bb495nSd2KtuLK+WuwjdJA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzy3Kk3TbtpTAID17sl6WcDi5hsWD1o4uwYwEmt1h0RvoGQC1O
	y4VxVIXKqjIdFoYUaagsxJJtKczhAFWqkMTo+7U4Z3haoXuxs0ilfd7h44qpqECwLzc=
X-Gm-Gg: AR+sD12z64bNNSh1h9e4wnrghCnP4Koyq5yB8t2qbVvRxNn6Jt4C0m235e5/ap5XTPu
	Wvg+dkGCWH+XFK1Q7hsAM1sqxfXUVETKKLsUf7D2esxLYi/RLt2yFEUS6w5UmFazura7EM/uue9
	2xietUmRo6EPqVQJgsm5jzdyDYXgdDswR3yutoBme1VJfzOH60iZYSN0MhhzXrOy1k9ghfhTxZ7
	q+kYBXen3g7Z/N+CM3xiIQpSZbVekIrJ8S/eLxDbReyZbt9+Q90Lvntd5r2Y7nCD6o/OAr+JLfz
	/gRSFxikJE5Ve9awuI7PO8V12CtfMyzsZ47u8BzVT77Exmzepo9bP70wxcJY2+qP3QPUgzMTWno
	iFSZR25iLDezaZGHdPrfh1lK1pNrDqBRS3S3rVXoHySVXE4WmA5wqET2TI5SHD929kgFZ0nX6Cb
	IQ1BP+tcPsw7AtiX6wp8qJyReelo76aWB1jtoahamdF/wfYZW2bqAln3XvmujRxeopp+e4CInnt
	q7okpFcFA0C6WkASMjjzJtQ
X-Received: by 2002:a05:600c:4e56:b0:499:a69d:e14b with SMTP id 5b1f17b1804b1-499a69de2fbmr38435355e9.4.1787054335163;
        Tue, 18 Aug 2026 04:58:55 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7834dsm11494313f8f.28.2026.08.18.04.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:58:54 -0700 (PDT)
Message-ID: <674042ea-243c-48f5-8010-9181f3e99f06@suse.com>
Date: Tue, 18 Aug 2026 13:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] module/kallsyms: Refactor current symbol filtering
 into is_kept_symbol()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-3-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260812032807.15034-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 5:28 AM, Tiezhu Yang wrote:
> Currently, the loops in layout_symtab() and add_kallsyms() duplicate the
> exact same checks (i == 0 || is_livepatch_module() || is_core_symbol())
> to determine whether a symbol should be preserved in the module's core
> symbol table.
> 
> Rename is_core_symbol() to is_kept_symbol() and move the entire checking
> logic inside it, including the special handlers for the first symbol and
> livepatch modules.
> 
> No functional change.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Looks ok to me. I'm also fine also keeping the current name,
is_core_symbol(), as Huacai mentions in his review [1]. I previously
suggested is_kept_symbol() [2], since the is_livepatch_module() check
is moved into this function. However, is_core_symbol() is still ok, as
it is consistent with where the symbols are assigned, in
module::core_kallsyms.

The important part is to avoid duplicating the checks that determine
whether a symbol should be kept in layout_symtab() and add_kallsyms().

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

[1] https://lore.kernel.org/linux-modules/CAAhV-H5w8VVW_L6cRes-syjEvhbWmevSKWrZWPFapRkuemmjaw@mail.gmail.com/
[2] https://lore.kernel.org/linux-modules/39a48465-22b6-4b18-9f7e-ce258513181b@suse.com/

-- 
Thanks,
Petr
