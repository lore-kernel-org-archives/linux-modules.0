Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EC5B1FB;
	Wed, 27 Nov 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714671; cv=none; b=e2JH/QDz7T5/A30fhWLW5jwLdHwMdYOze1ki34yJFyYEFZ1kfnwsnaPbmEkAawhLdoxS3oBpRV1c2HkohAz2z+QZ1IzGyUq1yFdYy9C5/wHXGV7dKSd2lRlUVj1aspQlzPOOaPCVdZDprIrvwlfN/7t+yZ8dv0xDutTtzT3lt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714671; c=relaxed/simple;
	bh=7BLDPRjezzrPTylfDKMlVkHNqDFz8czcYJdbiT/QvsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQ7F5CmCFBHX9Bj7PBJU8BqmYIzsIY+NTsV98Zlk/esJOtQO7r82wqoe/Rcj44Abt1pGOwf7mV9zLAuJuI0aFDMANqBtmE8JelQNq/tBrR1SjNv8rtkvsGZFviqaKlcLkwWK2NJOmMgbFVTEsz/Rw2Ac18bkFXzC3a1OciltsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xz0qn4kLkz9sPd;
	Wed, 27 Nov 2024 14:37:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1E04lGo2aPGq; Wed, 27 Nov 2024 14:37:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xz0qn3w8bz9rvV;
	Wed, 27 Nov 2024 14:37:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 73D2B8B781;
	Wed, 27 Nov 2024 14:37:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id JM7LPTW_LVok; Wed, 27 Nov 2024 14:37:41 +0100 (CET)
Received: from [192.168.233.90] (unknown [192.168.233.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F84E8B77C;
	Wed, 27 Nov 2024 14:37:41 +0100 (CET)
Message-ID: <15637735-cb71-473b-8b8a-21a6d6c5059b@csgroup.eu>
Date: Wed, 27 Nov 2024 14:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] module: Split module_enable_rodata_ro()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <Z0YoSrSNCIcvHsBl@bombadil.infradead.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z0YoSrSNCIcvHsBl@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/11/2024 à 20:58, Luis Chamberlain a écrit :
> On Sat, Nov 09, 2024 at 11:35:35AM +0100, Christophe Leroy wrote:
>> module_enable_rodata_ro() is called twice, once before module init
>> to set rodata sections readonly and once after module init to set
>> rodata_after_init section readonly.
>>
>> The second time, only the rodata_after_init section needs to be
>> set to read-only, no need to re-apply it to already set rodata.
>>
>> Split module_enable_rodata_ro() in two.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Didn't see a respin so this will have to be a post v6.13-rc1 fix.

Indeed I was waiting for v6.13-rc1 before sending the non RFC rebased 
version, but I can send it now if you prefer.

I expect it to spend a few days in linux-next before being applied to 
mainline.

Christophe
