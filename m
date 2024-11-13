Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225A185B4D;
	Wed, 13 Nov 2024 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480574; cv=none; b=S9oYJbgko7Y96i1S2atB4O4KLeiCoKS30HmBPUxX+a/aYFIjPLRsCtCaIIPUCgcpaGnWN7rpEohxl/NMdSn+U2ZvNI3rJHiR8U+IpA1EnhDXIpebmWs/BK7jdw5AM9Ql1Kq+lhWDDdnavi1jaooH/2T6QB5tbZFVJTj3mdEjKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480574; c=relaxed/simple;
	bh=qY8h9YfIduV1/2BdNmxjq6BqNrITa03Tapgs0IcbciE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBqfD1kRnhUwe9khDTVpNxgbZjXcaMIBxZ4pQA3HMY5ucG8qPgjXSAvKNuXpcC8pd0Qrmq3erJ5Rs5Rt1ayXGIgtCkuj5tDw1+K9AWDkggSt7pFItRbIFe3HgxMsmnTXXCxhMWv9+z+3wsa/NvXQx9+vSLzmR3ZhkJJFAgMDFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XpDR91s6vz9sSX;
	Wed, 13 Nov 2024 07:49:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aC46auzS1EMF; Wed, 13 Nov 2024 07:49:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XpDR90pD1z9sSV;
	Wed, 13 Nov 2024 07:49:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EE2268B768;
	Wed, 13 Nov 2024 07:49:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hECZIqXctbqS; Wed, 13 Nov 2024 07:49:24 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B59CC8B763;
	Wed, 13 Nov 2024 07:49:24 +0100 (CET)
Message-ID: <fa0f038e-3066-49de-bcab-97a779735665@csgroup.eu>
Date: Wed, 13 Nov 2024 07:49:24 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] module: pre-test setting ro_after_init data
 read-only
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
 <ZzO6cNo2MalF92OV@bombadil.infradead.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZzO6cNo2MalF92OV@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/11/2024 à 21:28, Luis Chamberlain a écrit :
> On Sat, Nov 09, 2024 at 11:35:37AM +0100, Christophe Leroy wrote:
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 1bf4b0db291b..b603c9647e73 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2582,7 +2582,7 @@ static noinline int do_init_module(struct module *mod)
>>   	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>>   #endif
>>   	ret = module_enable_rodata_ro_after_init(mod);
>> -	if (ret)
>> +	if (WARN_ON_ONCE(ret))
> 
> Do we want panic on warn systems to crash with this?
> 

I would say yes, for two reasons:
1/ It should never happen
2/ Such systems care about security and don't want vulnerable systems

Christophe
