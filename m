Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C0143895;
	Fri, 20 Dec 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716860; cv=none; b=htZmiH6jcbsdC+oC1a8zfSIp/54v5zpOks34yvyEvzzf4pOYIpxWk+GOfR61e9MGN/Yt+gsTsGAXmlKl6s33OhhvoLq9R4ak43dvFXLObPKcewtgZbqY9KgNlq76oRqUe14VLYgg3QfGb+enz/jJVYTE8STV9vlG7p6Ao7VQyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716860; c=relaxed/simple;
	bh=SKYY4o1NJARtBC9GlemQAS1QiZPqGK5hgSW2q95ObGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sh8Q5sG0XaO7SmiSQfM8JxxfKN7VkBOskdnqbmY5pmMlb8yUOBd8UnEOk0O1V0uvbxTYrm5I+WhtuA7ZsrqJJLOLy328YhdRrS82ftscP5dMFu9Se4r+AZDL2+2FG3Z10skHdVECM0z4yr9pcxLQum+kD2q5GNRY6upk9iC99JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZ5FEIMp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie4xvAwJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZ5FEIMp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie4xvAwJ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=izFTIJO0PVpbRJeglZYaRjpRKCqYZ2X2RNxjy42uq/Y=;
	b=NZ5FEIMpIqHBcOFPmVmBuB/Pb2cuz3Xc+tIZlgBavoNEkJ4PaiE9Y1Q+9cD7wM/5eGw9Vm
	kQsQMCbRdSMSiQAlxcEQMyHTgjthneP6tWwaj1kWlpoLoUMMnHJdd54Oh6txFkMTI7yZ9M
	hpJSExRHFR+BY2s0iVrdWj78K/jtY2M9pdgg3H9vf8T3L8hXON37+xpbUFOM4iH005Azbx
	IJRNqDdsBGI6KT52gyTUDOWCUJmd1A9AFu6ajl3IBEXvt6VGbWex74UaziTzqQYNGJU1ph
	kGPKtVPl5pBi3ARTVBHq8IIga9ymRSAFBZ1mwJ7d4PLSS5PXVF4mBQzfJrlS8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=izFTIJO0PVpbRJeglZYaRjpRKCqYZ2X2RNxjy42uq/Y=;
	b=Ie4xvAwJoTzL1DUI18qE26LJUijWIxKZog5u8Hgy2cwrTaN0Ds/OXfPmJL2o2AMgEdm993
	nsg4Y8GahdV6LeDg==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/28] module: Use RCU instead of RCU-sched.
Date: Fri, 20 Dec 2024 18:41:14 +0100
Message-ID: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

This is an updated version of the inital post after PeterZ made me aware
that there are users outside of the module directory.
The goal is replace the mix auf rcu_read_lock(), rcu_read_lock_sched()
and preempt_disable() with just rcu_read_lock().

I've splitted it into smaller chunks which can be applied/ reviewed
independently. I'm just not sure about the cfi patch (28/28) so I added
just a comment instead.

v1=E2=80=A6v2: https://lore.kernel.org/all/20241205215102.hRywUW2A@linutron=
ix.de/
  - Splitted into smaller patches.
  - Converted all users.

Sebastian

