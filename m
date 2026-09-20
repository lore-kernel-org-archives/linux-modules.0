Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86F38DC51
	for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789935148; cv=pass; b=XMWXBLdaCrzspX3NslEQmxAjMolOUvHunLQ8CCnsxqKcLoltkHYWzQR1e8gi9pbPuNgo6bjpWDI3+IO9IARojASDse1/2+OefoGQa9adJGfE7bGmD6UkeSTsOMZB7l8GT72VBYLea7KffZqpD5wJvVtG8A8WcEUY5IULoF+klAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789935148; c=relaxed/simple;
	bh=YH6ovs2GM4Gb+M+haBtrUODmJrKE4n7H8J0N3oX2GV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ/ey//b10IrRagYtHTg6595KQLrP8n/hO2GwhzPJV8cZoQ40RMwAQL+X5nRSGWqSJjV7spO7cxDpCOk3PLc0z6VwkSiabFeXOpVQZNhOo3RiNwCSjEGRqvTeMxEZs1F7jy/9aSgSC7D+OLBBjsV7C3HTRIS2/TdfM69SGbSQ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEKmGRJh; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEKmGRJh"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d6ff2f2c4dso4308285ad.0
        for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 13:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789935147; cv=none;
        d=google.com; s=arc-20260327;
        b=NO+CxheFsw6RakwlFcbGMvmXNHLYSA7hWHrqNOe+cNc5198y0MJ56bv8pmpSdl3uEz
         +m2jEmE9UM5THaF/1rtAMt6r+k4QzgBvz3QQhtMW07R4SkU9oV6GA+Yj2JBAbws1YXwx
         e3h5KAwm4cVCs+fuunU03p1tY0QwpldCIJSmWQGNBnXweXAhwFMPbM2Wywugab9tLMa9
         QRh8A2WFzog1pY55sA+Rtb35q3WfZAezyO4O7ilbrTak2x0COCmn6/71VEULk0t9jId8
         g6FyeGnHmvGI3ADTe7KrJAx0DQld8X5gcY4gr222rDvLpBpDPQBtAOPsBDaro65K/5mS
         qJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YH6ovs2GM4Gb+M+haBtrUODmJrKE4n7H8J0N3oX2GV4=;
        fh=g6l1UpVhwq2OPZDYkRMR7cnXEehisNb39rFipC0BlkE=;
        b=ARncWLacLCXaUeibQ7VHroxsRSbYjSAo4E65aoFkGvzrW7CRWtX3jMIQkX8SvdkP8S
         mfYRGsKdWv3rDhUqTOhlgpMdaPD46e54xhm6X9zXoMIDN9AY5QcOVmgXZHGLD8zkVvq2
         PcHBp3KKX8o/YuUEBaWssg8RMKEy2lwHSzoJpqrAeDPVBhmB6qkYY9lyHRelS9D/IJUY
         pduJ2npfLuC7x6Qn1NwX0+5QFv7kJzWOu4ObMl8UvOdscHJwQhhMdDxG31SPY8zsmcb9
         44ZSGNdPUayTHqnW16SZ+qXWB4JHrH6DqeFXQtLVDCKMgixSNMn+A8VJV+jQzh4g6GGE
         eKfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789935147; x=1790539947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YH6ovs2GM4Gb+M+haBtrUODmJrKE4n7H8J0N3oX2GV4=;
        b=dEKmGRJhpt8Kv7FcU/2WPSj/PYkCDPkb6se0YbSKhBGPFm0eDkFnuTw83o5iVlPANv
         M+w59htbc+L0XjkGfuLn88lJyHJaL5P3fRHmIRKVSGqABcBe1AJpO4PvJXQsL0xLdjaE
         vxgpxiul4Cot43RFGyXrd8v26qMUWAbsJpw3CJ3lA83WNKknmpX0FeEO43/ZNbLxTeYN
         TygG805kETOQjxg5A/OSwNx2w3lnPvqTuWphWiUavHOrvcmy1g/DBeIrQBc22GDbZNq7
         1J42O60fPvFGo3YY+KeoOdJOBjxWzyhKn74tK2NQu898G/ot9StZY14EM0I71R2KoCrh
         +o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789935147; x=1790539947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YH6ovs2GM4Gb+M+haBtrUODmJrKE4n7H8J0N3oX2GV4=;
        b=kiAkvCHQzWqEwoaNSi1yT0zi/6ReVbemQWfxYYoKiOmidIjVxYO0Pf5F+vQNZbG6f1
         giNIGp6fDEQHUJ80EutXxcFcMUMzCn0D+kbHUDoR5Zk84oEjNGIt+9fhElrcLKTqhuwE
         7vKnqC2RHXO7aAoEYHRjW7cwoCC+76UoXa9gqMek+42+td2p1FvU4ix4JDCM9rFMAaIt
         1vyMqg/w0j5ivVBMFWdLWhfVAknaQ9sQkN8mIxQ0AENVYJJ9VtYpn8Z3Ka93VHykOXGx
         3LZ6v5e0hzHRw6kne9c6fAeC/6tfoO4Ccft6T1GgV4Hajj+wThi4CcHj9Muctlc9cZXS
         m+wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgXv1CeVF2MvWXQj+6M5cihhFBKmHQFyqWvKPCGaatTv0TySHqCkwiS5Ig4g1zTZtHpbucstnTkQM7rbg3@vger.kernel.org
X-Gm-Message-State: AFuF++loHQzX3wshhDKNN41mdDh9wSb+I8lQkmr/VpslsjY+OpmKo9lh
	j++japZ++EWtpsH5Uu9CJXl1Am8aTymeAsoZCz6SG09a54sEHJa2ih3whmpVw2ao9x0a8eVCh1x
	QK04jEZHStjjKmxrRkp7dnK0gKAoh868=
X-Gm-Gg: AYBFou39VJo1WHPU9GaWGfgWnkCdhynqn7f6waOHpYjtxm1anAN9TWwVbaH5eL+9lsv
	f+0nr0gK4g2aeiszQQHVgltJuWprk9Kr33CLyrFXsN6pNHheF00+gmPnMqDZmhw2One1YbZXIPf
	dHSQicQSuzHpJ9pqyD184FkWIRg93ZGvpDr3H5l0lCyOLPDuvzzh6/agpSjqrYmvcDTfR8VawgG
	Gc6xKvpthnECwgywK+t/8AHFGLT0DgU6VycJ/InjHypQmE5sHSmc+yeUB0Mr2St1Xy7oPQa2g3Z
	S7PGRA+Caz+MMwVm+9aQKtlsAi9KNCaeswybA1jKv3CWtDFuXj+vZIUkGq0m+v150BPC2G8O/Sn
	dPLg6UaWDbqgJM2eOVpFpSlU5leOEvOdJ244kDM6K0fTP+2fEQh3PkgA/AH9Db2svD73aPnxXBU
	ikkdLExIo6gc9nP2jYRQ8lY3V7YowCz86me51BllnLVzxRiONF/yU=
X-Received: by 2002:a17:90b:4c4e:b0:396:d27b:86a4 with SMTP id
 98e67ed59e1d1-39e594253c0mr16168801a91.2.1789935146983; Sun, 20 Sep 2026
 13:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789426258.git.pgovind2@uci.edu> <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
In-Reply-To: <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Sep 2026 21:12:10 +0100
X-Gm-Features: AcwNN1VexTLA3BPLQdHuWi6jhCGpYq-Doon1BCGU3aUkkVr4dsmuI9o_2OcQux8
Message-ID: <CANiq72mkoPyo=H8p=QspKOQXEKPPsWyG46UFETX4reK9eVBkhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: module_param: Fix potentially incorrect access
 of `SetOnce<T>`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org, atomlin@atomlin.com, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:43=E2=80=AFPM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> Fixes: 0b08fc292842 ("rust: introduce module_param module")

Before it is forgotten:

Cc: stable@vger.kernel.org

Without taking a proper look reproducing etc., it is indeed true that
Rust's default representation may reorder fields (even without the
flags).

Thanks!

Cheers,
Miguel
