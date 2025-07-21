Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751582DAFB8
	for <linux-modules@vger.kernel.org>; Mon, 21 Jul 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108834; cv=none; b=p9eCtFwq3fIXUCiXKyY/VykmAHXFM7ZSZeWyw9CnGr9z2jhvadSa/TUy659fmz5lXQ2HP8spJAwQ6dBf/ELjL84zTe4EDikHc1siv3WEREeDxP7pDKXM1sAbaOePvePBcXzNVjXH6tSPJtIXuj9PhBK581JiMZAoY9Ev7I18HA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108834; c=relaxed/simple;
	bh=iGUp0dU/j2ZdmVwOtmcSmdjuk0Qz8lvGofOd2PTtUTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCydp3ZcbqDYyd1mx7XnCqWcX8vaPVZTPQhZphe62/DEPnzj01lXa2+dROdFH5/S8sPwi9iOK6+cqKr7vsfPLy9gmQCy5z1pgUXWV/q5xCeAWtP4GPahjTgA2fXWnf+Yz4jhCNYSmQ9JiGlTu/EiW6ZHkw7bqgZhoDd/DHO69m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TbYFfBz+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TbYFfBz+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so7711439a12.3
        for <linux-modules@vger.kernel.org>; Mon, 21 Jul 2025 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753108831; x=1753713631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ulo84xZ7t36NNeL6qul+IkvI9anviU2HLbOPblgw/k=;
        b=TbYFfBz+6aOKX9FecZwEa/TH9P1M1WrZJqFCnlwaOSeDRIn+chIeKyjlpwwpnMS/NL
         2OkzEMFvaqT5k9GBw60NzYaaG629kO08nY3NBM9B9Ooegos6b5V/dvhTLZ0m9ejmpnct
         5N/qbN7etEg2C6j+ePwi0SXs4p/79cdgBnFdXoYR/iFBuaNLhiqZioT9MNmqbxgXBSOL
         b/LFTnzk2QkDWUo/o7acKTvRJrTEx+SIUdK+P8Et8C9u77/DdZUhFG1MYEAVvYbiSyIC
         F5SQKbKi7VXBMRgU9QLNiEGybfu9fMjJ1ShLa2H+z3qM9bQgtIvISbEuLIrTxmwbD+/3
         WMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108831; x=1753713631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ulo84xZ7t36NNeL6qul+IkvI9anviU2HLbOPblgw/k=;
        b=f7TI5yoAbZ6XMotdPcudUEwgDWDuANZPf+FJ91DPe3btxkk6nPkExIyjmlxQzO3Z00
         7SL4AWkR/bxaJMMBs8wGc4z68yKVvzw65R4HOSqmIyo7aTjzeAJjPU3L2ehVcbmJFgiT
         V1QOfa9huZWJVc4V4uljqCKG071IvNjeLgClMbz7GhzFwXxvErr8L0XySJX1in8Ytgu8
         iPHh0gE9pz9tQoK0aq3K8jLMWNCOFKxFY8dvGpmYYD8Y/MLiKx68ZJ2qj67ZNOtEabLO
         KEmXSO8MmQ5rliH2bbTVQGUGDd5gcLE93Wo2QHvRHswfHqjG0rZvt//oJbGiqdjKriAJ
         Vt4A==
X-Forwarded-Encrypted: i=1; AJvYcCXh/LaejDQnGSdCksg499GoXeoyijpgWjdUsXOErwi18wt+Tn8GEBbvGVXGkkvW/0Wo0GdhT0H4rICZdZQo@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUHXERm/moITXzgzg4TpZEjx0jpUcAX9Kcw5z9zao2SwVU0Ma
	C6TkTIsjb/o5r8gB3hfGv7Ay1aBJ8XEyGGa9uGfIgGNmyOXuxEM72TrQKs/8Li2rQR4=
X-Gm-Gg: ASbGncuQJXc2IArhQuFDq8GA5No0DtFPWUeEsqD6rkOq3g3T+c4F5VtjxLy5OkGUdjW
	mZaVnFjfN4RqZham0Sur7ec/HwGMBeHQEPGON7HXpRVdhtFrmtqduniMLSgPKZ+f35b/RyqTpqS
	kprZZKEB4hbL1rJqHA762VUWPwJUCqSY8u1/ezsvLUJL4qrUQDC6OQxXgeFS5lsRd5Nx44xdqJ8
	A809wIxNAHwAbRdAxv/SAbS6AoBhY5pNDlDFWJPT0BKERHHwHjpYFt75zHVSPvA0c9qKOVYzWM6
	lIRpirJhb0NqkpZM9vIjG3iZgcDS30bLVT8BTcpuOAZT8a47YnuCYtSP6iEnHR61BN7egZvyJ1v
	tcwkBPgW5nW2xptCrRPnOmWEmb72PU4acE67kMsiBjqM=
X-Google-Smtp-Source: AGHT+IEH6XXULLKH2PA+RJRxowZuccLIs/Ri/UE41Z0z9+TdJgKpFlvZ4BqpSMCYm1zFe2zzzylsNg==
X-Received: by 2002:a17:907:c808:b0:ae3:a3f7:ad8e with SMTP id a640c23a62f3a-aec4fb05ee0mr1737210166b.25.1753108830669;
        Mon, 21 Jul 2025 07:40:30 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af11411f1b5sm28655266b.48.2025.07.21.07.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:40:30 -0700 (PDT)
Message-ID: <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
Date: Mon, 21 Jul 2025 16:40:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
To: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250721045224.391745-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:52 AM, Wang Jinchao wrote:
> When there is no version information, modprobe and insmod only
> report "invalid format".
> Print the actual cause to make it easier to diagnose the issue.
> This helps developers quickly identify version-related module
> loading failures.
> Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
> ---
>  kernel/module/version.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 2beefeba82d9..bc28c697ff3a 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>  	}
>  
>  	/* No versions at all?  modprobe --force does this. */
> -	if (versindex == 0)
> +	if (versindex == 0) {
> +		pr_debug("No version info for module %s\n", info->name);
>  		return try_to_force_load(mod, symname) == 0;
> +	}
>  
>  	versions = (void *)sechdrs[versindex].sh_addr;
>  	num_versions = sechdrs[versindex].sh_size

I think it would be better to instead improve the behavior of
try_to_force_load(). The function should print the error reason prior to
returning -ENOEXEC. This would also help its two other callers,
check_modinfo() and check_export_symbol_versions().

Additionally, I suggest moving the check to ensure version information
is available for imported symbols earlier in the loading process.
A suitable place might be check_modstruct_version(). This way the check
is performed only once per module.

The following is a prototype patch:

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c2c08007029d..c1ccd343e8c3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1053,6 +1053,7 @@ int try_to_force_load(struct module *mod, const char *reason)
 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
 	return 0;
 #else
+	pr_err("%s: %s\n", mod->name, reason);
 	return -ENOEXEC;
 #endif
 }
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 2beefeba82d9..4d9ebf0834de 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
 		return 1;
 	}
 
-	/* No versions at all?  modprobe --force does this. */
+	/* No versions? Ok, already tainted in check_modstruct_version(). */
 	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
+		return 1;
 
 	versions = (void *)sechdrs[versindex].sh_addr;
 	num_versions = sechdrs[versindex].sh_size
@@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
 		have_symbol = find_symbol(&fsa);
 	BUG_ON(!have_symbol);
 
+	/* No versions at all?  modprobe --force does this. */
+	if (!info->index.vers && !info->index.vers_ext_crc)
+		return try_to_force_load(
+			       mod, "no versions for imported symbols") == 0;
+
 	return check_version(info, "module_layout", mod, fsa.crc);
 }
 

As a side note, I'm confused why with CONFIG_MODULE_FORCE_LOAD=y, the
code treats missing modversions for imported symbols as ok, even without
MODULE_INIT_IGNORE_MODVERSIONS. This is at least consistent with the
handling of missing vermagic, but it seems this behavior should be
stricter.

-- 
Thanks,
Petr
