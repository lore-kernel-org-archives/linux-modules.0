Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36E3ED126
	for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699998; cv=none; b=AEmz4rqmGFiEo2H6hpBwYepbqGYXb2/N2rzppfBtl2PNPq4tTZhSRARh+J+dPWsNO3wFWt3wXxMzvX6r0GEHt+70O/HBHqR6pDvVkx2HkuYQZyw8UgFxdJ8IZ9cTg9rp4Q4HIy/I7EO4t+Q8DlcTjnG27vJSwS9ubYwxEcJLQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699998; c=relaxed/simple;
	bh=LQqeWLUXpCQ3xWzoSnndmXhM2WFPmN77ePTrKVSZm2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1NpGN0FTLr/xUgPb66bu8rSmdxDV0AhESLTx+4fF5JmlnYEFezI/g0Gsn5SkGfige8b06Wj2sMNCBcRXiZyx4T8Jxi/FPgjq2iGmxPLPnW4TxoX/G96uU2gvMhpImLQxZXJ4stdizkTGXD39QFbp8EmoKOYbTZCtz0XYmNWh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gLnWJc3T; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gLnWJc3T"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3637b90so45248545e9.3
        for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699995; x=1782304795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZi5bo8Cugwshp04KdhwM9Mfr4BTkMqYISdeW8xQXaI=;
        b=gLnWJc3T8g5mPH0ygz7/MKXwNq0sHTNISHAeXBM3sux0+KzF/+5k2Xip4oIBTnsx3y
         f/HbwTeE6dSxnCgdfRmx9u1XTNWc7GJx6kh/zQVMRbeYsYJO20cTpu+UBP7w2eypER5Q
         odDwRzIuwBFKbYaOBFtEZSHF3BtSEpm3UipvxXOvZNEieSx+ha5SXIfUaoMrGD/A7N+3
         BsStJODsCHhRGW9axRFQbrRv4o61l77DTHVYKtIXUqQANatvYejwz9iVHQLONtIblt3F
         Br/Bo9wXwhm4hv3Q+B7liAEZomGRP1vf+Iy1pO20aar5Q0a/cbLeJTXnRb68lD8h6ASJ
         G/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699995; x=1782304795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZi5bo8Cugwshp04KdhwM9Mfr4BTkMqYISdeW8xQXaI=;
        b=roJgPf9ryMHTmNjT1JEUnGUKFkgXRkii/HS+pFkcAU7i9S4wi6YVdV9gTrSGnR7Vyq
         zIKGqbMDUKna/gzDQZNJMZ+EVAEQZIS/FLUZhL2bgq9txkO3a7rt+bgmfyrA80zdv+Fg
         aDIlL08ewWJyE/wm7DKRIWMYhmFk7dFpvnXc98CqreDDj6QT3PBDDMVanDB2NgtBbrU/
         b0rMRBkUS2L54lnzGIEUibn7XcXwYAMFPXyJCk2QcOCV2mMgQ3+NksdYpzLyTEw4gp2U
         RYGdGcsJcYOKlIovKgY2bBo4AI/rzQaqyUH2xIw35RCUvO9QVkUfdJmwdmrW47WdVW8H
         n+DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dZQzfEmBxXIhDQPYG7d5hf5+5AtKt0J51wRZWo4aSSnC/YPav7ZaOXei2J2nwHRlHMVYWkAustQ5R3M11@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkoxseFvldYuIaKgPcQ2u5b7o2Q9CExZoNfodUB0vwslVvpVN
	uJsB9vf6Q2YLs/Yu/1ubvjrk4JqAcaAYhZaBTPfzx1ZGd/vdDtOknr5PyrU4ns5twEI=
X-Gm-Gg: Acq92OELvvBkA5gjTyJX7r22smPYMf8XFInhYYOvQ0K0SSpZjNiTGt7pCM85nQfn2JW
	IG8+reBDTuzKDG0Msefe64HYF+5yZ3EIzDrxix4Zc4yyp57VTRUlK8dPfqjpJ9flHhFngHFB2Jb
	RrZUi9A5vSr+GBbMuXwLmvttWaiEHhrlyPz+XIqSY9ZTo6RmdceFXrGXR7/vZZM20o8FK3JsojX
	QksUSoJnwJv219CHcomgBvaB45wpED59uQ23zLMcSU2IaSHlspJsy/oIaer+z7D7q4UFe2qSlxl
	Hmh++58gHa4LPlsHZlujEOZvil7IY0iNEVhZwHCz1QsJEkDeUdbB9xlMwnFoqdu1i3xrldea57b
	khbN4sqNs3PVBdyhWlQm/QigJZrDAqk36xkt9eqIrnTcFI7EXWjoZxhRlOAEGLvBxiwkY3WgpqF
	jbj7iAf3s1TeUifB7ekvoYC1wcc1a7WQ==
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-492333e2b9dmr46704045e9.36.1781699995234;
        Wed, 17 Jun 2026 05:39:55 -0700 (PDT)
Received: from [10.0.2.3] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa891acsm161753865e9.9.2026.06.17.05.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 05:39:54 -0700 (PDT)
Message-ID: <79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com>
Date: Wed, 17 Jun 2026 14:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist status
 via debugfs
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, neelx@suse.com, sean@ashe.io, chjohnst@mail.com,
 steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 8:13 AM, Aaron Tomlin wrote:
> At present, identifying the correct function name to supply to the
> "initcall_blacklist=" kernel command-line parameter requires manual
> inspection of the source code or kernel symbol tables. Furthermore,
> administrators lack a reliable runtime mechanism to verify whether a
> specified built-in module has been successfully blacklisted.

My understanding is that initcall_blacklist is primarily a debugging
facility. This is documented in
Documentation/admin-guide/kernel-parameters.txt [1] and also outlined in
the initial commit 7b0b73d76651 ("init/main.c: add initcall_blacklist
kernel parameter") [2]. It is expected that to use it, one must inspect
the kernel source code.

If the goal is to allow specific built-in modules to be blacklisted,
I wonder whether extending module_blacklist to also cover built-in
modules might be a better option. Module names are more appropriate for
administrators to use, while initcall names should remain internal to
the kernel. Additionally, initcalls are typically "static" and therefore
are not guaranteed to have unique names + using module names avoids
a dependency on CONFIG_KALLSYMS=y.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v7.1#n2408
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b0b73d76651e5f88c88b76efa18d719f832bf6f

-- 
Thanks,
Petr
