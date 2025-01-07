Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27061E47B1
	for <linux-modules@vger.kernel.org>; Tue,  7 Jan 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247534; cv=none; b=kjZ2VO6aYQ1XqO8gXj2Maw21h18FTihLlgtll/apd+kL0gI8sBrWOKnV+NAa/03ncEQjal2pA8Xg7b1QYd0TTJzRzBqzBL+BadWYHKD3t5TRPwkR7UgcQAbXo0rq4ylWHDjgAYYv3GrzocZXHoYbHz4tEFR0x4IqkFW0rgPZG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247534; c=relaxed/simple;
	bh=IxvNqk0jlDoy7K3bX8hkBg7IOVfZsilaZEB/X7GEW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3/bBTWvnUi7leKCUkwVoqUCnkV5b8OMUdADJUuPvSRGInZYOTPExLXxDthMOEARQL9DI///Pdg6pTPdq9RVTAo4cU0yA4FDQUlLe2bwIjVwHH1KxRpavOCDJWxqWKAxMRxyjiK+rq8l/y2nEiCpMMOmkTuUtnTiVCZ/WfzXfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zz5pfYCj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zz5pfYCj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so197066145ad.1
        for <linux-modules@vger.kernel.org>; Tue, 07 Jan 2025 02:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736247531; x=1736852331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfvNApDEnkYxo9wayRnoayueQp1chw+vILiOzbCROK8=;
        b=Zz5pfYCj1G0AlOy9g3pLcT+63zCdb6M2pAbac65HmY6coIPgtsukxLShQNobHHyUDj
         TSbrMzkm+E70eTF1Zu0zvhptBu+cdDt/BoiAEqr3rHxF+GGNkjVVIxTd59AqlQvhzBop
         1lsmoCDemP4/snQOg2teQFCkFj9uSb5iuu648=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247531; x=1736852331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfvNApDEnkYxo9wayRnoayueQp1chw+vILiOzbCROK8=;
        b=r4sj5HQT0iMKKztNcXFwkk1pgNPB5uBL7qWoymfuAHB5D33DhmVlc8buyhpQtLNHH+
         mAhbVNqwRaRIpQqm8uKsb+YOvWKVcE66ZrcPiJv+fVqZ+4qbKWhaGxKFD3k6wyLz44BN
         /ZqeR9dAcRXxG7mTvQSAXcc2Mc1UUgbisSvBg0vd+Vpp3Mf1baoRlZCdbNheWSMGX79J
         4hz8z5tPHd1kmouelpTLCqGnqBPKxXYPy33GFi2aeTCOK70YDrvH2pqvcgLZq4UKlJdO
         I7/MD1XP/+fdIlaHur2OwUl5w3cyo6BDYMx26Y4J5AeYLMbWqEKkbvzL+KjmccL3Y0J4
         x5+g==
X-Gm-Message-State: AOJu0YxdF6b6KGYEAm6HFt+bjZ8wTWpRY8JFYuC7GzhnFmqIE+wV7Nnv
	3uiLHjZSVf+35CB+d31Cb43+68d/OHP2P7erHoCIW2MlGtD8KLd03qPIkhlKaw==
X-Gm-Gg: ASbGncs3DaSdWNMfTkKymvefQD+Sdd+eC5n9meUYzvl8oPldFhpbkQKsGSUfnWxryS/
	Mm0Oq1noPIILXR5TpkRYjGRc6bWTk46DENxHQnnE1fLu/Ee6DbA/U91MV4SkxqHa491NG8OSa6g
	fLlhIsIH4ffRnHRF5go8AWQN9Pce7Bxh4dtQiUIW+WuGr0dbxp38Y71mIqDmMfTeN/hc+8qED+u
	AoX4OIY6edn0oUYLdLi7IBl9TdwGvX1lvk5fhtzCFte+je4xB3F879ZkONv
X-Google-Smtp-Source: AGHT+IGNgNCUH8eyQMCUvASISKoR6AY1tcPkTy+eXP5eG0bm252IvAUcQpZz2kuI6Vj2Y7ykEyzoAA==
X-Received: by 2002:a05:6a00:35c3:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-72abde09893mr87978739b3a.12.1736247531428;
        Tue, 07 Jan 2025 02:58:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c142:c1e8:32c2:942a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb34sm33168531b3a.87.2025.01.07.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 02:58:51 -0800 (PST)
Date: Tue, 7 Jan 2025 19:58:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 01/28] module: Extend the preempt disabled section in
 dereference_symbol_descriptor().
Message-ID: <kknhqunwsiumn2dkdhnc43ecuzdvqa7zws553gnocnksz5vl36@jllfly2mjegz>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220174731.514432-2-bigeasy@linutronix.de>

On (24/12/20 18:41), Sebastian Andrzej Siewior wrote:
> dereference_symbol_descriptor() needs to obtain the module pointer
> belonging to pointer in order to resolve that pointer.
> The returned mod pointer is obtained under RCU-sched/ preempt_disable()
> guarantees and needs to be used within this section to ensure that the
> module is not removed in the meantime.
> 
> Extend the preempt_disable() section to also cover
> dereference_module_function_descriptor().
> 
> Fixes: 04b8eb7a4ccd9 ("symbol lookup: introduce dereference_symbol_descriptor()")
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
