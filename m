Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899139F176
	for <linux-modules@vger.kernel.org>; Wed,  8 Apr 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661900; cv=none; b=N3QN8s1phobyqXMk/3nmLFS/VSlU6aMEVR3twbh7NK1GXiodvU/eNOySrl0gC11gP4Mi4s71UzStjGwQJ7e7UBeR0e4uul1qpZE5BqQ4hbI0sxlcqH6Neua7IFyjpoMRpBkxcbYkj4lsow8U1lMmbWyo/cdk+z1qHTYP3FOWBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661900; c=relaxed/simple;
	bh=Xvx5NbnOpNGEloDoPzkjBb0luYYTDDyuKVmozJ9v8uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+8UjXfotvk9hebYfhDnAYrdW1L5rclxVKeH3EdSaGyiE9qR+U9VGDPXd33iS6/emDAtgQAFh3islMYIFW4OpLeMkcMP78boJshYTEJgbOxnTaUxxAkMasCNuFveXUt5kJJnoOdkjtIbAH+K4Qo65/BA3k7CsMvEuJ7QGZvzutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQ8bUH1h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQ8bUH1h"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba840146so23225935e9.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Apr 2026 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775661897; x=1776266697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laiXp2rBEiPl8a2Z73ajRETlDqB8PAbCI44ILQPyqZU=;
        b=KQ8bUH1hLy5ICPteP8XT2Q6t0+rlQFNWsPFCl0HCql1CbnJ0uRDCxcVkPRvqW5Kzgn
         limg3sB/6MZcSJOUeCuCA/6yViMs/f2/r+0Cq3GsW+V9sUl6nhSOXPNuY+kI6gvgD8wO
         CZSgsI1OHjm/agsWyGQR4XpR8DTSZZK+J01GYz3kjzgci60g6mhIu8XLlPLz1iFXHT8z
         UEqYixHVm1J2RzS/zBZ7Oq2k9D/x0HOQN43GiF0wmtUhgXlz4z65B1OHdS+Gh5cDTQ0a
         GyhodOMFStaJvY0TN04ONJXSx9wFzSg7MV3oiH6wQdoz1D/KBTVwe+ujuiU7srTaXg1/
         FpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661897; x=1776266697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laiXp2rBEiPl8a2Z73ajRETlDqB8PAbCI44ILQPyqZU=;
        b=aLbPXZhqYgrWjtL40eJx+a/yTQytFA/7Gx7qJ90gHGhI+zjg3BH7CE7nzyc/zplX/7
         6B0fA75F74Mm/BNls6i6UqxFyXvxTGykS4yX1g+Q1LJHrxhW8rh7F7/CoPJdq6OYs439
         GgIFGnoDeycbFv9EYEtb2A2WevmD8BdXI+EyqJPcT4QNpfOihWGFHn/e2yigr6xKoa51
         COLDgoTnisiMy9N6H0wAqnblDVQwZg1bFoGC6QHTFJNmhguNH+E4zcUvLb1MG9fuenMy
         j0kVfEUNNuB315/hsuB8tjnEtKieWKi7MveGK4gJ7wArEOHg3E6+IQmdK3ttz+L/e7Qs
         +LsA==
X-Gm-Message-State: AOJu0YxWRzoAyQPrsHpgZ+ASLU5xacE9vciZM5j0p8T7QTQSkzGFKHhM
	jjj2SsCSvM+GjkpEqfKmPMgbVn+iDU5qoqg57AIkNR5XWE9kj39WawvXZ5KFw0tLndo=
X-Gm-Gg: AeBDiet6m7qycZE3NBmkmkHcbnINGiH9ghlddgfm+1pd6BOpXXskDT3cpB43alggTVF
	EnvMmmEXFaOI0WdqBtMYmP3YJoxEJyh7oahBOslYhs7Z9r4qVqgdRb4G5oQDnxqfwzT+NFrxYrB
	uVl5KtjsTlDINkBcbxv8wpJNC1marCqQZZrdSw6HcSbITXTeqYYrXHIEsoB2nTgRcV7X7BXWQBy
	GFPGdDHLOEa5EkV/JsF3rj3AK6zM2CtrcUlN49SLH/JH7ruOljiPtPsfgGEYO6JoMofQmFx8VS8
	8m71xSRmujiVTGs1DqI8PuXg7OeLqgeirQ5OdzlZ4AxRfXGvbE6tlQYZzpiSyv9pEitMDRftQ77
	F+VpV6aa1OD6fPcShZuAAJdCBKFiehVih/FRjC92J2zBdA625MZ+pOicUIiTQKS27CeZLBeLNAW
	1B5mXjFI42orQ+3Ytin+hOD3efWeNscBVIbwnUikhLKNkm
X-Received: by 2002:a05:600c:6208:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488ccfc0554mr2091505e9.17.1775661894090;
        Wed, 08 Apr 2026 08:24:54 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1bb778sm32985e9.7.2026.04.08.08.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:24:53 -0700 (PDT)
Message-ID: <999772c1-ec48-407a-a0fe-64665620d855@suse.com>
Date: Wed, 8 Apr 2026 17:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] module/kallsyms: fix nextval for data symbol
 lookup
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 12:00 PM, Stanislaw Gruszka wrote:
> The symbol lookup code assumes the queried address resides in either
> MOD_TEXT or MOD_INIT_TEXT. This breaks for addresses in other module
> memory regions (e.g. rodata or data), resulting in incorrect upper
> bounds and wrong symbol size.
> 
> Select the module memory region the address belongs to instead of
> hardcoding text sections. Also initialize the lower bound to the start
> of that region, as searching from address 0 is unnecessary.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

As a side note, I wonder if manually determining symbol sizes this way
is the best approach for modules, instead of simply returning the
st_size of the symbol. The logic comes from the original implementation
in "[PATCH] kallsyms for new modules" [1]. Unfortunately, the
description doesn't explain this aspect but considering that the patch
rewrote both the main and module kallsyms code, I expect it was done
this way for consistency between vmlinux and modules.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=d069cf94ca296b7fb4c7e362e8f27e2c8aca70f1

-- 
Thanks,
Petr
