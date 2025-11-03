Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425C2E88AB
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161555; cv=none; b=MD1NBqmZOSG7Fj3liX8z0p4hKPRPRSeSnFtEM1WB+94ZQwXyx796p7+yP/Prz/B2lCq1hoxyk1Vf3aM7HLxArWuonvMpI7GT9buHgctSk2W0kh8vczBfpOFLYELJO2EoCh07sQWMaAodtqTBthLxdYIQjrkBhKnShJVvUMtbr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161555; c=relaxed/simple;
	bh=0Y9caYOqSW11yivpiI46fzV2GqLE4ZF0InC9uXM8/Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4V1XYhIaIaIT6m4d46Rlac9lgyh7nqURnpQbJ4AesKqzJ7gmRvIsB6p+en3X5JHLvh/SnUl9x8pDvZh3ubuzaLBQ6J8Mo/VcMgTUM0bG7THQaH+3M1nfZpbq4weZIi+Qv0ZfIoeFvdfMG2FTQLfnsVvMqTBau1MsQs8BQ+AstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A4XDX3no; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A4XDX3no"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so28667045e9.1
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 01:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762161551; x=1762766351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ynz4s33e0TLs0d6hGvRQqkDSiZ1njMSQRICWUdMFEU=;
        b=A4XDX3noApDwzL1MuaWiwkzukhdKkVkO3pb3TyJc0whbOiiYMgnE2/F4HG/IcE3JQK
         kW4Pt3bSbpiLDgRaCJmRVcersuoR5hYRlam7pqJ9Tf7xij0Yk8E8M4FuwgjIC4O9aZxP
         8WD2Q9H+HufJj14gT66qpDnmYuVGN9VYvf7KxA3/uy0N5jXM6oM+VJDDW+GvuQSjrDAO
         CB4Ymfyt/5gJfhmOq7HH73uWpPUVRkaCAX/C4nM/pozv4peaUiQlumVs1UXsVDo2htm/
         M5ZufSct6XdrodB6I0yX/J0SCLgYUYq0cx6LEaGPXMXfFKtrXafW7S/Zc76WmbqIK5qi
         Geqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161551; x=1762766351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ynz4s33e0TLs0d6hGvRQqkDSiZ1njMSQRICWUdMFEU=;
        b=g5oIYt+tpemO3+JSW+y3I6HLNDDl1TDi1yTGrmi3sKj47lPQiT/EnFoBG5X9o98N0A
         znwwNPkBLRXP1Vws6b/agjB24A83J4Cj+zubfWqiCZzhnxyruoeWTtRfjIaiEGX5019N
         qqG7+9N4b4nLxwfpLAQMUhF5hrm26HpX+gsY/c4XnNhoEhvNKCocTra8i5f5TvrX6mi/
         clVz8WhvJIfMtM6PLh5BgYc6pawfl6rnKUoGoQlGi/Yf8w5rP6AE5f/Ia4APkk5hAFZu
         wAaju1LAuhCNdx1H3/ciMN3lyWT22tKJwPE9d8W3GC5Vq0Bjwx01ktm4B1/hYIR3R4P6
         13jA==
X-Forwarded-Encrypted: i=1; AJvYcCWLVKzR89fAm0wYKMijtOi/VY9B+2dC35gtKSd3qJjaGXlMdjZxyVYERPovL1ytSZnRwZ5+TMVMuGZisPz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47XhIJcN8GsSET8p3BGjoD+S1vSGkaZADvmsWJy5ucvdJX9Pj
	9FXLopFEs+Vr6I98dvBiThfw+uub8MjSQC8gPsGCjxZYbx0Ac+1dkesiw7QpEPzbpaY=
X-Gm-Gg: ASbGncumjC1ARhooeXOUtjxaDVWXA+p0xQqZTfLRojMLuqUb0n0rxyaHrRjTESlE7uP
	13Lzfo5aULVzvjtMPlY/qBhhXhcGgVsY98l+UyFq7GcPQlyVrNRN+BNpiBaclJgDG9N89I5+qTF
	+D80jqVhIcs2ZjoLgZqoxfj2BmX4Oop9HV0W2AGawO0F60u/b3+SGr4bTj1yCqjCHsYmMp0Y0PA
	Xo3MTsTAIMExA4uJwE/rpzpVkm+sn9qTjkwxIPbcGmIusUidn+uIfpvxekEcG7NUl1jULDyrqGh
	opneQo+M3Q4ilXn9n3S2VOh33QJoQbAu1SGMbzlkOh77ngWpMJ9Zr2rhmVoFX6TZXYymEV5iSP4
	Z079ES/YaF6KbMDx0thhgu8XXjwgD1seXbchVW8I7w/0XHsSysB6v1FPh04fdgL/IuV+9ZPwHR2
	qD22HhCagqBXcbN6E982Qt8g==
X-Google-Smtp-Source: AGHT+IEWfWVVzQFxN3DAZRcF5k08MxsMc9ZYeQ4H54jSP0UkuFE80X1DOa7SdsC7jiBDXkya412Xcg==
X-Received: by 2002:a05:600c:64c3:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-477301041d1mr109894515e9.10.1762161551158;
        Mon, 03 Nov 2025 01:19:11 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm7626939f8f.24.2025.11.03.01.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:19:10 -0800 (PST)
Message-ID: <7301b0fa-5463-498f-82a0-f40bfee462ba@suse.com>
Date: Mon, 3 Nov 2025 10:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ABI: sysfs-module: update modules taint flags
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102060458.517911-1-rdunlap@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251102060458.517911-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 7:04 AM, Randy Dunlap wrote:
> Add missing taint flags for loadable modules, as pointed out by
> Petr Pavlu [1].
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> [1] https://lore.kernel.org/all/c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com/
> ---

Looks ok to me. I would only move the "[1]" line before the
"Signed-off-by" tag in the commit message and separate them by an empty
line. Some tooling might rely on the tags being separately at the end.
I guess this can be directly adjusted by a maintainer that picks up the
patch and there is no need to resend it.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: linux-modules@vger.kernel.org
> ---
>  Documentation/ABI/testing/sysfs-module |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20251031.orig/Documentation/ABI/testing/sysfs-module
> +++ linux-next-20251031/Documentation/ABI/testing/sysfs-module
> @@ -59,6 +59,8 @@ Description:	Module taint flags:
>  			F   force-loaded module
>  			C   staging driver module
>  			E   unsigned module
> +			K   livepatch module
> +			N   in-kernel test module
>  			==  =====================
>  
>  What:		/sys/module/grant_table/parameters/free_per_iteration

