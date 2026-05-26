Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F013D539
	for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800627; cv=none; b=aQqbh44oQt4AxzqzkAuNkVs/4mrmcY1Pd5OtemDBDfp3p/bVBqCaRi+QX5OA6F17EqvvgikgdFGbHBVEybQXnB/Icf4g815AgqbSIeOnBlfFkKKMKdpwTwfPS/ibOM2rVflasJEvvKLLdvvjXp5LRLkd8g+CJZvthaZS6rWPoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800627; c=relaxed/simple;
	bh=cIV7eVLFj1WSRdO8UJfWGAKcQ4RL3tgfGuH1jAdS3kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ98z2ZrVRcm72qHJVkHiBVVFsvlV4SzolDX1ZWrNL/BzB1Y7FUGW8F145D9+xjf4xjCXIHbC/citovbTE/oorBh0rmlSi+rK+Q3NqBxwmVcVxXO5uSGvnsT9rXSdOP5m7+oPnmmiY5OurqoEva9nShaqwAnXreI6iq21h41jL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CkA/ew8b; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CkA/ew8b"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso50136555e9.0
        for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779800624; x=1780405424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=CkA/ew8bHQnTyLbheU0tKlrPxe8xDGNFqQotUJEMcWW3Tn4izx9/5Wr69fbvqXNIrH
         eJhcFYm2FwT43HFHVhup2TEWSY9btQCJdzdHC25FcRPDFu7X2XfkNGJQk6Y1iz5JxwKo
         QjRf5jvXL7ImDuU+nVFT6WEDEvaTgphh6DX+WVNxkUDEo6LVdU1oGl6Nwp1zelB8yVRj
         tqr3xqAOovFmzd70qP/wIIL6ed41pFKIxGQCy6wcvHaKBqF7L7MzEay+rWNRiDWepQU+
         +gjQOuGxUKKqxIyCOBXsupJUjswmD1ds9yBuhKnSOtgCrorIOlMa4DmTgbMDlNkJIqBL
         tWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800624; x=1780405424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=nweUwsr57WubhZq2CcL39Tz1myQkrbd7LI6RjPPu1YNhXCsCR2qvA3AKxCW3PmsbTN
         ORw5PY0/0oXmCcYYKQQ7WuC2KaC3FxNj8ZVcdPlhE3EObb3mETRP2p/NRPqoLAq/MND+
         ZxAtKrBWPaySUw2LsJdDt6e0tqui9XP3kW5uBlF7ylIrvBb8BZIvQ9sjdU+0XPRvch0B
         yPH1FQJEDN2ynNcFfVllaA71nfm9oe/R1y0PC4YovPtH9AD4cThvpQAjAdMRMt7ZVmQk
         pv0ob95VL1LdyViVW/WTAqILOpHKnLmMgiSq3tJi9JWMmi3ta9Rt/n6Ss6T/W8330fLQ
         WWHA==
X-Forwarded-Encrypted: i=1; AFNElJ8EwjjZ7sRtQxuWjNvzS/ffwMgpJqJ7YMmHd8n28UUeYsSnbSRiRXisVYtBNxZGxvZq0oHR9/zO5qRdksmJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+Hspm4KktCcFzCOdCGXw5ez+uFwxLDe7jx1DWO7xLJwQO8DC
	L3O0wkoH2ZxQFIIgw67xJyXzMLOZM3UMZqc9AVsGcO46J2Q+e8bCAwtwLg1sxEm9i4c=
X-Gm-Gg: Acq92OENbemgMgekL8j1ZWodU/2/J5bCU4tHWaE1d+wAyyvp9FBSH7mgr6Xu98hxz7W
	rMn8Xw/D/ipuYaN1kpgdKuQEAADnR4Pl27ofXdEWgxDBJf3BuZK5p9Y9PcLyDs/v2i+KEHrCwNQ
	e6DjSGdb+tSIAeQk0CcdIn2E1ANm0Yz4OoRqy+cBIv2TxeNTVuFCF69rOJV2qVsMIWbE5CB2eiS
	jl+twSE3Ouc3C2WOxBsbCGHhK2XCsNEMipgmYbbDVq/y3dXkopmOUXayRyG5a/MBluZA5WFuQAr
	1B5FSpfOrYgzw6hChS5yVYy/SCLkkYDOVdkIV2Ncd/2sgVf+J4J5XYDK0fvI3RT387tXJ1FxJmj
	PWWXGH0QITVo51PdT9P/WvA/2wuMTnZ+3LEwoTLrkq9jKdGKqAyQJezTKOHHGg42D8Z/pzQkf5t
	nY4lpwaSPPXGwRu6bIYyNFpgmtqJYU5WUbhwu51W74FQ/C
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr223327865e9.9.1779800622880;
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm318501285e9.10.2026.05.26.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Message-ID: <635fed3c-4e39-4357-acd1-13f1653f9e3d@suse.com>
Date: Tue, 26 May 2026 15:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Additional signature types are about to be added.
> As each caller of mod_check_sig() can have different support for these,
> move the type validation into the callers.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
