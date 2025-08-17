Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4561E32CF
	for <linux-modules@vger.kernel.org>; Sun, 17 Aug 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447637; cv=none; b=KmiHEAfr9YC+pRwdYZ8Y4Wy7LIq/cbLHac9hpOWejk0cgvCOUy9NJy2hVfAbpYHJ7lCpP2bR/zmwwBP5KRO5AlpjqSiQVtdkuWdjKy7RWoW8wcZQQ+hwvHEbywyUqwPSr6XU81HMh3gO5KamhXS87EEjXJfYiZWPd1Nu8cA/9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447637; c=relaxed/simple;
	bh=5MMCxLF57qEJ3lYkvenZtY42DV9TzDIN6BRieQyLO3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmU9txUdAUpJ98N1rFgqG3ZPnIkHBxp9FFIgZSiKSLaA4+W/cysJZQLJMziWDO6MFbiMt8HrMzqzAmECsN6FpWWC9ZXrbj2B0CieEX+ReMQiOAJIdiwCl2Kc67lJUR+lcz+tjEuqJM8f8tM3rHv7JDMAB7ljL5rBsGRBLDT9sRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c4gQD1GTFz9sRk;
	Sun, 17 Aug 2025 17:54:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmRaWPbUjW2d; Sun, 17 Aug 2025 17:54:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c4gQD0NScz9sRh;
	Sun, 17 Aug 2025 17:54:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E7AA18B764;
	Sun, 17 Aug 2025 17:54:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 78RG67D7hvFG; Sun, 17 Aug 2025 17:54:27 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ACA808B763;
	Sun, 17 Aug 2025 17:54:27 +0200 (CEST)
Message-ID: <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
Date: Sun, 17 Aug 2025 17:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
To: Phil Sutter <phil@nwl.cc>, linux-modules@vger.kernel.org
Cc: Yi Chen <yiche@redhat.com>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 17/08/2025 à 01:33, Phil Sutter a écrit :
> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> I admittedly didn't fully analyze the cause, but on my system a call to:
> 
> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
> 
> fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
> tcp'). A call to:
> 
> # modprobe nf_conntrack_ftp
> 
> though returns 0 even though module loading fails. Is there a bug in
> modprobe error status handling?
> 

Read the man page : https://linux.die.net/man/8/modprobe

In the man page I see:

            Normally, modprobe will succeed (and do nothing) if told to 
insert a module which is already present or to remove a module which 
isn't present.

Christophe
