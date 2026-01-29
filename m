Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EE309EEC
	for <linux-modules@vger.kernel.org>; Thu, 29 Jan 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697876; cv=none; b=Ye5bP3YK30ICr2gJkpJuSfJQLfxXh5t2k/Fglzmg8eQe8pqPiW8XtOEzPdHVRyhTSvoqC/k+bmfRqvgKNEfp2ndVgyn9R5DpSqOiyU3wn0ftx4haRACcf4rO2Aon1qlSTrMWcznFbe5EPoIgvjq5iKxiDpwKFghsbI1ksfBn5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697876; c=relaxed/simple;
	bh=0cfpgEZxAtHlg92XqcFn2b1AgT2Rux9sr9odOOPM6rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omc941qAI1NAVEy7qwScYrjwlrTomtN85CAD4qT4wtwg7v3yNoD6HUO7kkEpx61ZfxgsdAjBPi6oqcnYd93/+6fS2LFAhQ89E4RaxB2/cM6HPx+1/RjA3kigbCSPHeFN3zMjbCs2YKapGd4YarRDu7rG5jUUJQfkAGA+6LGGUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/IlH4hS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/IlH4hS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso9597125e9.1
        for <linux-modules@vger.kernel.org>; Thu, 29 Jan 2026 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697873; x=1770302673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=b/IlH4hSx+B+6rP5XO+ZCDrdqIqZNwRvFmk3IzNbmVeUc+S3/VL/Q5SYN5ja/Dqh6j
         COyyMc4qNfR93w8mVZzfHB7aPkwrvmsmYNZuatgAFU7PZ2Syv7MPZbndco7ydj7+30D2
         vz0NOGBbj8GqWuNQ2UvQHk5mPn2LY46vylYlbMpdeXXyplDvYLNjggXVxcnfYaanAvTr
         H/yw+UBIWwHlvJKPzSyIWnhBaaXYm7/MQznVaP1yJsh7ut1ecphrx6aHukIyBbKQW1ix
         2ppFJr3Rk2uWM22v+p/ag9GslNOlj7dExRrweweudR+1g0BnHFHKuA30BEcjkLT1ZrSu
         YSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697873; x=1770302673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=gxasZr+Q4t1Ql7deQ+XkDIaqBsEV/VQwEPtX5xDZj1SLYUxoiSiZp8YvPQLOkOuC/O
         xhbh3iCX20R2sWCvE/4qzHncpvZCg12/jJHsPGbwvcAdxtSDPaAvXvKyovUZj1O2cgR1
         1XFh1lapA29bgE+vwRazN1Q7lkkXhuEQwz90oCXU+Vun0dJZN00Qg5SmbGCtKrHeUVJv
         7IVc6zrB1NqDA8heB04tq62GndTd6mGB408UaKaXG5Wj80uU7EWHSagDZDjd8xM4ZjYO
         RDpdVXiDaoSAGeW+42Mgl59wInbvCFQi94+ULzXi2WqpZ6G+bCClp/SAsjFm9QiGIevu
         JMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVngWZ+kLsEg8SB55w4pB/K++ajLwZTyCHSgJ+4+23jKIIXUS8N+RdAFtfZ+Pm05Q0mSuCoTDQNTGrNPYbf@vger.kernel.org
X-Gm-Message-State: AOJu0YyHm5cKHuJS8vmA9hlr8OEuHc59v4cDHZ93fBpY+54gG2vXBjVz
	FaauVPr8cWQnEwW226Ca1bXpuyKe5jhoetUFsOs5G8C1cUAS4smokV7Oy/VvOkg+DF8=
X-Gm-Gg: AZuq6aIG1un6PEb7Ukgb8JuHFTZekj5jM2kYu4Knr+BI4sIuvlv8aKrS5k8BcMr9Ssd
	vk4n4PkNadKLZOOKoPQGPI9kMUpbFVgCN8H7i6pFcbu7CRuOAESguBAz3XvtMcqylrF9W41Okui
	W6f6lywZCLnCSfy70y3iYRjuIup0FzRwr2c1R2LBlN/wmDv4n3D9CO5Yye6kXbRBNm6N3QwVn0S
	EDzny2pz4J7m41x0hUkaIrYilqzvUOCKfPGas23el1QUXdnzRd9JdHaARezkeh7wuMWqQ6jVRWC
	ebwAzGeAuDyTT0WaKb2ZdMA5kCBSAVBN/aPb6Kn76y2BVE1l/4ao86zhMev3NkjrfVzAJeGKXGN
	qzgryai18s5CeUVrcZi7gqF+DOHLPaX8AMaAEH3fVZGm2fUovWNhN2fTqRUJyDWITP4zhRzAuWI
	jglRk+INH7fA3BtklM1Ff4K9jNJGVzhg==
X-Received: by 2002:a05:600c:c8d:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-480828ad89emr46795915e9.11.1769697873050;
        Thu, 29 Jan 2026 06:44:33 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm166871115e9.5.2026.01.29.06.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:44:32 -0800 (PST)
Message-ID: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
Date: Thu, 29 Jan 2026 15:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> This needs to be handled by callers differently than PKCS7 signatures.
> 
> Report the signature type to the caller and let them verify it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d65bc300a78c..2a28a0ece809 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
>  {
>  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>  				       MODULE_INIT_IGNORE_VERMAGIC);
> +	enum pkey_id_type sig_type;
>  	size_t sig_len;
>  	const u8 *sig;
>  	int err = 0;
>  
>  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
>  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> -				    &sig_len, &sig, "module");
> +				    &sig_type, &sig_len, &sig, "module");
>  		if (err)
>  			return err;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
>  		err = module_sig_check(info, sig, sig_len);
> +	} else {
> +		pr_err("module: not signed with expected PKCS#7 message\n");
> +		err = -ENOPKG;
> +	}

The new else branch means that if the user chooses not to configure any
module integrity policy, they will no longer be able to load any
modules. I think this entire if-else part should be moved under the
IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
patch #12.

-- 
Thanks,
Petr
