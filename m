Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC53655C7
	for <linux-modules@vger.kernel.org>; Tue,  1 Sep 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265820; cv=none; b=Bn0iU6OnDcIju/8czclYT8azMm2r+sXt2BoLoxL77qVGpiWqJ2E6dj9deonb7i5OgnPDyEKC2q/IKY5Ztfeul2PmUSSkI8N2k8kHyR1mHhm2PWWMopDKN/F+GDY6RYi3Imfch2PN+BH9wO3AnzcJ1q1yc5OkS1nJyjRf7qUCMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265820; c=relaxed/simple;
	bh=xThUvjdylwBDO6UwJ5v4XHaCCBR8EDO8ug8okqY3IZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvVFH+wv7PccS7yX364hfBb0jgnrM5BdPDdEtQNekj1rJvN+IMQhlimXV7mEPE3RTjFd5HSV45XtdOAL4AA5py4LstJpHZWeAFdZ3lcvgpgEujD8wvrGJbtsxQnXM6sIluXwOrtu8hBp09XSq4erQHbjfwbiqUYbT3cInOmzRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSWZNcUP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSWZNcUP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so50186375e9.1
        for <linux-modules@vger.kernel.org>; Tue, 01 Sep 2026 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788265816; x=1788870616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKiEJer3Nyo4mzcV6ZXVsxbGmSZdi3jrQ8wILC+MmI8=;
        b=OSWZNcUPKRTZ5GeiORiDrgLX+nLDVD7Pcz2TGYIbqrNIQG/TIVSaz0u46kBFCDzQhA
         kBLApCgLguQNt5F9FWvxLj7yAyFTUbbMJy5Axw2wlTArwXZCUjbvHHvhAQXFt3h4pNd/
         N+pD1HXq4RovHPX+ZwWmS7KveKYvi+nJ1I8qjoCtEgp45CiuR7fRE8j0mhlKpEKA34mc
         W/TGrz3PD/m1d0WtMfkSJ94wr8MZk6tAV5hDX8HedfEIeTu8IYp7y7v4wAdw0xTdOKBV
         WhtTFCv3mGCsHGgIezsHMm2LNzOjCBxEgxSQWgP0mphM4jTbSw7HyTOOV1EIX1NlW7Zt
         8NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265816; x=1788870616;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKiEJer3Nyo4mzcV6ZXVsxbGmSZdi3jrQ8wILC+MmI8=;
        b=CwKANlROoukA/AJTXnW222xvPh6Jp5p+98qruyBRUAyqvz3g0bJfSD4WjgjgsOr0po
         KiZ5ykHMHvVulvG4cs4hm2QrZXteDgTK/OduIpacdWmPrGusjleV22A02YXq+o2UAxA7
         2oiMD1EXp9bvR6Y53HGDkvmjHh6kzvILgcAT+oDApSTikNOGyQiiZGet1xI5M0rH6YAL
         0XQzl7lEGcZPSAtZLxoMDngy6bgzb98Qd0T7P25txcMo6CEADrWdxA5VjciFstMyiayf
         d7d72swMgJSE9fBpH1dMFR7ZjhkxUDllkfu/VzBBoJuby7MOvuPXksKlZOvjotu+KN3Y
         lmpA==
X-Gm-Message-State: AFuF++nmJhoM3TNFEBNGUMMe9pRMA+wbwxPJYrIClaqtyFokAapXz9eO
	gvkqK0af+JR9IXZ+SV+npokiFm0miNPZjPn27EyomxKCNj/CibbPvw9Ca9xcX6qvv+GOKfKQegJ
	+xrLy/+0=
X-Gm-Gg: AR+sD10hbnPdzfbZdgJug12Z+14olU9jF6dENQy5bAVdsCIKIsf+IbNDs6aaIBlLgLx
	Ba7LzPCEzWByQTXg/zMx2piiAqYN0Ii8exuejpazcnFOFX4TQdukJViVoEB6q7YoixqZLDnalKj
	G2oXmjxicjor6kGJv1iro/F4pjxBjI9Ibf+rpiQHaDaZz6UchHYV0ekTwHVHKylSnQl8zg3tFnE
	CcDdq1efhZZdWwPpyKNOqIu3NB48F6/dFzEzZSSBi89q0QkOAUwTgpk9xqfq80xo6/V8pOuSeJk
	loWDK/LRgGYexQqeFP6CAv1ggCmjtOStsQbgp9E6ITM+fGMkaWn1ld6QKHjb9h4h4SZQHNXK9sX
	mOI0EHgp01qPDhGOA25/Q88H1s5x41RBGizst9hal5rucIbHxnvMfxNSNqxMyb+WO/Q7rz6xjkj
	5B2hoArHIxtAU/AgdNoW4isBheJGYzRh86MTehPe/oTS2GKXAX5Kk4Mu/vQvc2XXyWcNHB893Z8
	/MP0orFcn7BEBQjspqWOt63
X-Received: by 2002:a05:600c:34ce:b0:49b:9205:45b3 with SMTP id 5b1f17b1804b1-49cdc572c7dmr156945315e9.15.1788265814193;
        Tue, 01 Sep 2026 05:30:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e4e7sm61698825e9.9.2026.09.01.05.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:30:13 -0700 (PDT)
Message-ID: <aa0a7e8a-c0f2-437d-b530-da23fe595858@suse.com>
Date: Tue, 1 Sep 2026 14:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] module/kallsyms: Rename is_mapping_symbol() to
 is_ignored_kernel_symbol()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 Josh Poimboeuf <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20260820125007.22943-1-yangtiezhu@loongson.cn>
 <20260820125007.22943-2-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260820125007.22943-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 2:50 PM, Tiezhu Yang wrote:
> The helper function is_mapping_symbol() historically checks for both
> local labels prefixed with ".L" or "L0" and mapping symbols prefixed
> with "$".
> 
> Rename it to is_ignored_kernel_symbol() to better reflect this actual
> behavior and scope, preventing conceptual confusion.
> 
> While at it, update the related non-module files, no functional changes.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
