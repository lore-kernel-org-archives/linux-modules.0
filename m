Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD238A711
	for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653862; cv=none; b=Ef5498aRuI8ofametwEFJ35DrU7Wsp0UidbGQo0e5JxA5gd0duXJYs+NqspTe8P7Mjs+4RwLKnnAH7wtPu1PugPO1m08ge8ggI0E3Qi61Tt+ktqsn4aPnUqV2RDvlnNysiQXO0HGJwQOOsNp5mWoXcj6O8IUr6nn6Gid988cjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653862; c=relaxed/simple;
	bh=ohtisd9bI4M2jrBNKDar3gcLV+SZLD/2KJOsPMTSQhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1ztfe5Foid2U4pLn4lzCcDLm/mj03SxYFD/j+RzdRdsRC6YL+lFya/ruGUdC8wlZsjIWs7IIr1YumRsCwqTkAWpojB2Nui/Rucdy0KMpdG823n2KT9Dw2gnzyA1N+RUqawwVG72Dmv3COO+y7hcDMJfESdIkTkRQEMXadDFIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEJ6lG6c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEJ6lG6c"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso40037825e9.2
        for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773653860; x=1774258660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4sLqVtfcMBLmTxrObzblhtIIUozWNm6DMsskCa56uA=;
        b=PEJ6lG6cAOcZ9f3Zw8N0ZRIRdSI2oxHEVdK03bAPFLXTWTvLgDyTDF6Rr22kzHrqs6
         0XAxs0n+B6Xrb+Jw5uVdVo52VWcP6doA1FXTYBJJHiuGD30L5/HzzMEnLrmqdQTqs3gC
         ww7hGb4TCEPkyKOeZFhSoWd5NnR4LgTNkaaBXWiUYlbSAH9TdC9LOTk8dDbpVI/4YA5z
         UfGUqoAYY8hiP7c1VFZNlVkxL7xlwUSZTs+n0dxUGvKW6zCIeMco7HHe+Tedwzd0lZT6
         54WOIqiF5+iwckypztJcFCA01XshoKETqau4IGG7EP23Nfh299Oep2BSJnP1V52G4Rkq
         9zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653860; x=1774258660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4sLqVtfcMBLmTxrObzblhtIIUozWNm6DMsskCa56uA=;
        b=omgxbYuUG3UwKFjRZwF+A5kAuWGouWUz3S/QF81aPJP0m4bneJGOYEjsNk4pRNNHp6
         P2ECztrlWR66kphcWDDpIahHOJCM9942zWuTiKHk6RpvxlLMqTaqxFOa9jRjvdTNjU1N
         iHYzLxd0rguj5r6J1M5d05TOG/hWs2qJKJRBfG1P4R34SGLR23aIUCnyzUPZ5Y4nGzlu
         3kfZ1/quafoXLjKiSMG3uFb6mYMAqFY2RYQRDeKAp0Z13gdOy0a3LKnxBC+7ICRDuQ0j
         /Jc0lkv1lu2D9UB7UJ6CLw3EOJ5DzKkoZLoplQcekKGCyoiHusnH2H+ozB6Y9fPWLnGH
         A46A==
X-Gm-Message-State: AOJu0Yw9IHO13IQkNym8WYBqVwAFV1TpZRgadZGu3D3E10rhDj81ywhl
	pSb6AAzovJpNjZzkRRq6cmSHfoYyMBSfYQgKmeiUPhiJuHklJ+8yv9aUmNX2UtP6NQM=
X-Gm-Gg: ATEYQzwwYpi7N6YCdhTA9OiBdBEsxl72x0V5LXr+iDdlMl6AcPhL372Evdz2Qpma7xG
	i3ESgWTV21Pu6g8tG3ZvMb8N7SH2CbospnqkeuKYYuUUFZmtVybOTZBOo0Ek1889yfwdZlQT54m
	01+M20fzErDmnCMZN/cmo5H8fUFgaNfc2PMgI3Fx4vSFuy/YghnimmYmeu4ntLKIaiIhgD7+6NK
	3++2Xzwtd4Dkhgu1NkOv+UErt3b0Nxtogl+gmM/D/iIpMflsvIYPnnJ24J687j9GjZH2BJCS2+5
	YtMU/aQer3tIxJ/KRyiNLepVU5YdwLaCwaBfGv2LXh/vwoSUIcbsp8xRwlUUh0ufqD8AfewUly8
	jgJrvk7zYz8sQTujYitqJNFgOxM9OhtuG+xmKDcD0P2JuH5YOV2UQEBf7I4NLTgONDlIPaJSU5d
	3H3zNC1dtRpvNlMmH3ECXWCH6ROXtWAdUhu4Lreq03btvbAFKcxIJ6Vjo=
X-Received: by 2002:a05:600c:4583:b0:483:badb:618b with SMTP id 5b1f17b1804b1-485567050e9mr210066105e9.24.1773653859640;
        Mon, 16 Mar 2026 02:37:39 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm888164315e9.11.2026.03.16.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:37:39 -0700 (PDT)
Message-ID: <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
Date: Mon, 16 Mar 2026 10:37:38 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: remove MODULE_VERSION()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2026031341-evolve-repeater-987b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 3:20 PM, Greg Kroah-Hartman wrote:
> Module "versions" do not make sense as the kernel is built all at once,
> the "version" is the overall kernel version number, so modules can not
> really be described as having a unique version given that they rely on
> the infrastructure of the whole kernel.
> 
> For now, just make this an "empty" define, to keep existing code
> building properly as the tree is slowly purged of the use of this over
> time.
> 
> This macro will be removed entirely in the future when there are no
> in-tree users.

I share a similar sentiment that module versions set by MODULE_VERSION()
are not particularly useful for in-tree modules and the macro is often
used unnecessarily. However, I don't think this patch takes the best
approach to phase it out.

The file Documentation/ABI/stable/sysfs-module documents
/sys/module/<MODULENAME>/version as a stable ABI. Searching for
'^MODULE_VERSION' in v7.0-rc4 shows 600 uses of the macro. My concern is
that if any of these modules has a userspace part that checks the
version, this patch could potentially break users' systems.

I believe it would be safer to start by removing individual uses of
MODULE_VERSION(). That way, we can also learn if we're missing any use
cases for having module versions.

The original patch "Add a MODULE_VERSION macro" [1] from 2004 doesn't
say much about the motivation for adding module versions, but it does
mention that they should be accessible via sysfs. That was implemented
a year later in commit c988d2b28454 ("[PATCH] modules: add version and
srcversion to sysfs") [2], which primarily discusses use cases related
to DKMS, and to administrators + tech support needing to know what is
actually loaded on the system. For the latter, I believe srcversion (or
something similar) should be sufficient.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=466ae11966ae380eb5e10cdf323e140d824fa10c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c988d2b2845495373f666a381d354a7f80981d62

-- 
Thanks,
Petr
