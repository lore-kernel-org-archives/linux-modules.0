Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7988F5A;
	Sat,  4 Jan 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735977010; cv=none; b=FAjj4/N44nTz7nLzMyf13ZC4OS+JnooRLC2DW30s/FmIVD+Kf/5KAVG0LFaaY+zQ8ZBgbAiAL2L6Wi5jSYcy5C/O1lwRLaeg5DRLzFiLeLGG3vieQ6gGJWnnO8N/KajZhh2Dt5lvRhl+Hcs5fNJIxyvsr+TXJPoM+xIOe7xxXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735977010; c=relaxed/simple;
	bh=BOZcY2PEZJNrA18CWQeKmfnVv6Fxo5CponpoeXQjDL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op7mx1gFldFdvvqfWhxCG1RUOHV20ELZGbP0r7r14wH2GvaddNuHRd/dUfpdKKiA0xtVwjDmSAX0Z2UbCWVZr4T6FqoEGxRzAeygUSOuFIQRoNDoXpyeRcyio8gf9x4sdQyCuQvsAQGwY7013WrhQChXpyxFueeoB5rvz0RPUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YQC8v27n8z9sj0;
	Sat,  4 Jan 2025 08:42:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPUUiXEvq7jW; Sat,  4 Jan 2025 08:42:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YQC8v1Gjvz9shy;
	Sat,  4 Jan 2025 08:42:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B31A8B76D;
	Sat,  4 Jan 2025 08:42:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id MAzJNypjpgUz; Sat,  4 Jan 2025 08:42:55 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B04A78B763;
	Sat,  4 Jan 2025 08:42:54 +0100 (CET)
Message-ID: <d2e5f644-500c-45a5-8606-159b513dcf19@csgroup.eu>
Date: Sat, 4 Jan 2025 08:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
 <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
 <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
 <7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
 <9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
 <cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>
 <95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>
 <d6a7fbda-4938-4630-b264-a4f6611bcef3@suse.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <d6a7fbda-4938-4630-b264-a4f6611bcef3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/01/2025 à 16:40, Petr Pavlu a écrit :
> On 12/10/24 11:49, Daniel Gomez wrote:>>> Do you envision that the userspace would handle this problem 
differently
>>> and it is worth adding the complexity?
>>
>> What complexity do you mean?
> 
> The complexity that I was referring to here is mainly the earlier
> described limitation of the current init_module() interface and the
> consistency of the module loader interface as a whole.
> 
> Another aspect is that a number of modules is loaded directly by the
> kernel via request_module(). I'm not sure how the new error would be
> handled in such cases. I suspect request_module() would be also only
> able to log it as a kernel warning.

And that's the same approach as for the core part of the kernel. Proper 
protection is verified by fonction rodata_test() which will just print 
an error when verification fails.

> 
> If I had to choose how to handle this corner case better (in long term),
> I would rather try to avoid the error in the first place, potentially as
> mentioned in my other reply by splitting set_memory_ro().
> 

