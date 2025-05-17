Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D01DEFE9
	for <linux-modules@vger.kernel.org>; Sat, 17 May 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747504238; cv=none; b=plVbtLN2KahtOxnCHWgEtWsUeFd64ZNE6y2GGwNqFrgmtVfmDxxVun3APVLFXCdEais4hvgPAjOee2iqCnGZXFT45FcZFnSS2woMXp0Pi5DTC1CWJChW1lT5q88i71unY6cpgAXZRUw7PIj5IJ4kyW90L9Kcwt8tSbY3wAEI39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747504238; c=relaxed/simple;
	bh=Bn0wAGqZHTjn9PqrGuc27qP6e3HVTBYUm5T+e1pNQcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EXf3wGVXVhcesOsIjVQXnp2Dm7+BcqI1cxg53iksnu/Y5/oOUjIH5vDZZSk5sB3RZYuPCVQbkMBvw8EKQBDzr/LNz2HLozkqnLp4R2I7CwPyQBs9FY9LI18jmdA1sKkkRJC6NNu4WgXqRACpQ/5eglOS842aZKVdLba9FQDC9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4b09p649qhz9sWd;
	Sat, 17 May 2025 19:25:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kOzLs8HarK8; Sat, 17 May 2025 19:25:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4b09p63MxDz9sVS;
	Sat, 17 May 2025 19:25:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E5438B767;
	Sat, 17 May 2025 19:25:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Vg09AF3dGqEw; Sat, 17 May 2025 19:25:50 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3448D8B763;
	Sat, 17 May 2025 19:25:50 +0200 (CEST)
Message-ID: <e55bd90e-8bbf-4eb2-95e2-cc636725a0ae@csgroup.eu>
Date: Sat, 17 May 2025 19:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: a module for wiping userspace RAM before
 shutdown/reboot/halt
To: Danill Klimuk <daniil.klimuk@3mdeb.com>, linux-modules@vger.kernel.org,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <bfe72929-ba4c-4732-9f80-25cc7b95a0c8@3mdeb.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <bfe72929-ba4c-4732-9f80-25cc7b95a0c8@3mdeb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/05/2025 à 15:30, Danill Klimuk a écrit :

> Hello everyone. I have received a request to write a Linux kernel module
> that will wipe any processes leftovers from userspace RAM during/before
> Linux kernel shutdown/reboot/halt sequences. The reason I am going to do
> it inside a module is to do it in a more deterministic way that does not
> depend on any processes. AFAIK Linux kernel does not have any other
> functionalities to wipe leftovers from RAM apart from the command line
> arguments "init_on_free" and "init_on_alloc" that results in memory
> poisoning only during memory allocation and memory deallocation. These
> arguments cause the kernel to clean processes memory several times
> during runtime, that is not deterministic because of processes
> non-deterministic behavior. Hence, I want to bring the memory wiping
> mechanism in one place and make it more deterministic. The question is:
> 
> Maybe the Linux kernel already have such functionalities implemented?

Linux memory management topics should be sent to linux-mm@kvack.org

> 
> Currently I am planning to implement the wiping process to be triggered
> by "reboot_notifier_callback", so to wipe RAM after PID 1 process
> finishes and no other processes are executing. I am looking forward to
> merging the module into Linux kernel upstream too.

What do you mean by 'wiping', do you mean 'clearing' ?

Can you explain the reason this is needed ?

Christophe

