Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016287603A;
	Wed, 19 Jun 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782674; cv=none; b=lAG7aFNRjMn0YO9BKEQFU+KxkELaM7CzW7TyAl1Tz/H97+hpjKPXPxZwFpzjcCMCMaI3U7XkyJ956T3QuR896cQ4Nm27uwAHKYMj/MAzCAWU4FPCh3I4SBSO7efVZiGLeYUJ/Of/NetBteK0F5KqzeSfGvgpclkEq0cXA9o31Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782674; c=relaxed/simple;
	bh=QbADky3jFoLA9J0+VbVp4KVYeDfZFjbQsCjoG0GnX6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsMbxwp3pkcQo2rf0txwYFUQj4jejdLnV2yrnYwy5ZsMa2lmhUNS+Ae+GHcp1fYxuPPGJpNpk0uiLSIMXqWHGm5kbkXfLg0H6xmenPhvRkoXKl0PuiTR9gp6B0hPtCovzLiFRC2Q0OI5Bv+D5tet2PizV3/oJv83QwfieLW5QAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnFrA/Tp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnFrA/Tp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f44b594deeso58132175ad.2;
        Wed, 19 Jun 2024 00:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782672; x=1719387472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZtpkJrERAytFRPCzO4ZBi2FYjGLa3zFY5Xobeh/H7A=;
        b=FnFrA/Tp0JPr3lXt3kTC7ZDZ0weltzVW2YPBNse6ZPY4vKX7Hjp77KBy67SDbLX5mf
         E8hGSjg1TjLUHWJO+btRR03PSP66mTaqsEDkpKw68LyF/MbLXxzCyGpKcZyQW/gxCea4
         MvooptHAEXi17uOa1neikzCf3tvQPndUNqc2PphzTDN1O2ld1DOC1WE507ba+8cG1Ioz
         3DWIzWIKQXUR9It/K4NdRSR+QSJM5Tgtj2UOoc4wCPTWnxvCk3B0Hdqhj2g/5f/IDEW8
         C9TD7H3ixPRzMIYBUz3MmN2IOmz93vS9Bwt20iL1V9yZzFemNtW/7tmo9QFoRppTIsGn
         Acmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782672; x=1719387472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZtpkJrERAytFRPCzO4ZBi2FYjGLa3zFY5Xobeh/H7A=;
        b=JbJFBfdBWo+fcOA46nJZguPhh9awEwdWTr6CBYP96NAf3dfFEXqKbaHKoqUeiQjXVT
         aVT3iO9cQLXlwWh0rx2kBeYqJZyifHNWAaLDEECxwkWmoypQsrNpmHvAL78Ij3qXqaFK
         OtX3WDX9mnjXbhUNghjSpENYvH8V8lnR7kALFDoAJBURo/8+d9Z0eF6Bh6M/U7ex3lgB
         RYRZWhF2+fuihR3v1VjcEy5/CUgOrBY/+hcjVaDVZyh6h7qvOWY6T6O2RJg2ytCgmmEh
         8LmxX9I5HnsrVF4DqZUaQT8934sghV82vBOy7GJzVR2luQrk3Ip2z7N+KcqIpXwURufs
         YrRA==
X-Forwarded-Encrypted: i=1; AJvYcCX32VlfJtq1vpRUT1UNWpZVMuSYEdFmP410nnSr/w8stn8MIUius0L0fq5Rg/g4zrs4yVvfuB7vPcljxaAY945R5b57Am/yT3aalJby
X-Gm-Message-State: AOJu0Yz00tdtSt9bsH2h7y2rtNTh6m3xOSbP3nmKIMGGf8kL5Pfg1hdn
	/8FLtb2I4H75/zjZsUzgBrwYSmHiqS97lf0VlFTtcCvq3HgfL7cY
X-Google-Smtp-Source: AGHT+IF+19ajajZtl58wYenVWrAt/kiJtPL/XURoEltqHCw3AppneQqbobx8Z/pbCyNiUb+yxmoGnw==
X-Received: by 2002:a17:902:e5d0:b0:1f6:daa6:e77b with SMTP id d9443c01a7336-1f9aa96847fmr17597125ad.68.1718782672119;
        Wed, 19 Jun 2024 00:37:52 -0700 (PDT)
Received: from [10.125.112.52] (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5b0dfsm109745425ad.29.2024.06.19.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 00:37:51 -0700 (PDT)
Message-ID: <e529ab0e-3b92-4e0b-bf4e-af7cd3266d18@gmail.com>
Date: Wed, 19 Jun 2024 15:37:30 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Add log information for loading module failures
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614092519.1611533-1-a869920004@gmail.com>
 <ZnHYA9dmtUEPLgYP@bombadil.infradead.org>
Content-Language: en-US
From: Yusong Gao <a869920004@gmail.com>
In-Reply-To: <ZnHYA9dmtUEPLgYP@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 02:54, Luis Chamberlain wrote:
> On Fri, Jun 14, 2024 at 09:25:19AM +0000, Yusong Gao wrote:
>> Add log information in kernel-space when loading module failures.
>> Try to load the unsigned module and the module with bad signature
>> when set 1 to /sys/module/module/parameters/sig_enforce.
>>
>> Unsigned module case:
>> (linux) insmod unsigned.ko
>> [   18.714661] Loading of unsigned module is rejected
>> insmod: can't insert 'unsigned.ko': Key was rejected by service
>> (linux)
>>
>> Bad signature module case:
>> (linux) insmod bad_signature.ko
>> insmod: can't insert 'bad_signature.ko': Key was rejected by service
>> (linux)
>>
>> There have different logging behavior the bad signature case only log
>> in user-space, add log info for fatal errors in module_sig_check().
>>
>> Signed-off-by: Yusong Gao <a869920004@gmail.com>
>> ---
>>   kernel/module/signing.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
>> index a2ff4242e623..6a6493c8f7e4 100644
>> --- a/kernel/module/signing.c
>> +++ b/kernel/module/signing.c
>> @@ -113,6 +113,7 @@ int module_sig_check(struct load_info *info, int flags)
>>   		 * unparseable signatures, and signature check failures --
>>   		 * even if signatures aren't required.
>>   		 */
>> +		pr_notice("Loading module failed (errno=%d)\n", -err);
>>   		return err;
> 
> I welcome pr_debug() messages but if we were to add a regular print for every
> single type of failure we'd clutter the code, we don't want that.
> 
>    Luis

Thanks for your reply!
Agreed. I'll make that change. The reason I select the notice print 
level is because I found the codes in module_sig_check() use notice 
level when signature enforced. In fact the pr_debug() is more suitable 
for this scene.

BR, Yusong Gao
