Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C3C7EE29
	for <linux-modules@archiver.kernel.org>; Thu, 25 May 2023 21:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEYVNd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 25 May 2023 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEYVNc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 25 May 2023 17:13:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03FA194
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 14:13:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2b74d258so169951fa.3
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685049209; x=1687641209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9SZgJkEuk57kDCIrdJoLldT8KXfqYqeFjG76R55NgrE=;
        b=Y62PQteEDiSb+Mq9J6Qk3sJgS9hg/POA/Uddj4XkcfGdr/u68NuO+xa6Jp4Epcd3cf
         9sOhGxF9IfhiFyle7I9QR/0ZC29ZUsge5Yl8wy+v8+arIexLx+sq9C0+TTXPK6FCuuWL
         93u1RdZTFENLwvDQ2jJkLyMsoKZ57OLfxcr7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049209; x=1687641209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SZgJkEuk57kDCIrdJoLldT8KXfqYqeFjG76R55NgrE=;
        b=Oe6X1E5ozkpDdHDNzN0fHKrVul4tglWuWD1OlmdYXpsJ3zLrhgqtPC3ffvW5HCDBLW
         LYl1hsmf1ykGKTwBqEgAbitBgkRrT2EJo+O6UU6Gp8+Rkh3iRrf+KKba4gYW7MsQzMGL
         QrQb858koQ6SSD2xaasPlVJI0bzl41SHkpe0PAKL8rLoYz02+qe+sBoz5W6u2umNYigy
         cw4rCEoJFHCRgy+fdG82dVt8grSGA8//dhIMfG2X2dtuZbWeFT3yBb6kyvkWKJSm8rP1
         vNu5aFC/HKeZOsqa5GfVsYnK8590+7wtflcCTdceeIGDN4od1T426GsddLvW//CWthto
         q4sg==
X-Gm-Message-State: AC+VfDybWPeP87FMQdQFYes9AWdJ3HEAX+Qimf+4IZLxxv42+CNgtgN8
        Qg865YzHhFVAHua5rJ4hKkMhyQCSxQdWmTMTURf4S2XF
X-Google-Smtp-Source: ACHHUZ74ii5rgys0MV+HTCCyWkTISBeBIAv2KIgWD9XWEJGA0m98rNluKRT3isniEw6RV1KmqrxHFQ==
X-Received: by 2002:a2e:8695:0:b0:2a8:a9f7:205b with SMTP id l21-20020a2e8695000000b002a8a9f7205bmr1478431lji.36.1685049208695;
        Thu, 25 May 2023 14:13:28 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e9f4b000000b002af25598ef9sm412794ljk.0.2023.05.25.14.13.27
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 14:13:27 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so2957539e87.2
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 14:13:27 -0700 (PDT)
X-Received: by 2002:a17:907:1628:b0:973:8edc:5a3a with SMTP id
 hb40-20020a170907162800b009738edc5a3amr82698ejc.30.1685049186309; Thu, 25 May
 2023 14:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
In-Reply-To: <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 14:12:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
Message-ID: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: multipart/mixed; boundary="0000000000002e29d205fc8b1635"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

--0000000000002e29d205fc8b1635
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 11:45=E2=80=AFAM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> Are you willig to merge (a possibly improved version of) your patch
> or the userspace change is still something that would be desired?

I think a user space change should still be something that people
should look at, particularly as the kernel side patch I'm willing to
accept doesn't catch the "completely serial" cases, only the "trying
to load at the same time that the same module is literally busy being
loaded".

But I've cleaned up my patch a bit, and while the cleaned-up version
is rather larger as a patch (mainly because of just also re-organizing
the finit_module() code to do all the 'struct file' prep), I'm
actually pretty happy with this attached patch conceptually.

In this form, it actually "makes sense" to me, rather than being just
clearly a workaround.  Also, unlike the previous patch, this doesn't
actually make any changes to the basic kernel_read_file() set of
functions, it's all done by the module loading code itself.

Luis, would you mind testing this version on your load? It still won't
actually handle the purely serial case, so there *will* be those
spurious double module reads from different CPU's just doing the
things serially, but the exclusive file access region has been
extended to not just cover the actual file content reading, but to
cover the whole "turn it into a a real module" part too.

Also, this does *not* update some of the comments in the module
loading. I changed finit_module to use "kernel_read_file()" instead of
"kernel_read_file_from_fd()", since it actually now has to look up the
file descriptor anyway. But the comments still talk about that
"from_fd" thing.

Anyway, this is back to "ENTIRELY UNTESTED" territory, in that I've
compiled this, but haven't booted it. The changes look obvious, but
hey, mistakes happen.

And the commit message is just a place-holder. Obviously. I won't sign
off on this or write more of a commit message until it has had some
real testing.

                  Linus

--0000000000002e29d205fc8b1635
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Attempt-at-workaround-for-horrible-udev-module-loadi.patch"
Content-Disposition: attachment; 
	filename="0001-Attempt-at-workaround-for-horrible-udev-module-loadi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_li3mpxbp0>
X-Attachment-Id: f_li3mpxbp0

RnJvbSBlMzIyM2JmYmRkNTQ1NWYwYjExMzM3YTU5MWZhZDNhMTgxNmI5ZDA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjUgTWF5IDIwMjMgMDk6MzI6MjUgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBBdHRlbXB0IGF0IHdvcmthcm91bmQgZm9yIGhvcnJpYmxlIHVkZXYgbW9kdWxlIGxv
YWRpbmcKIGJlaGF2aW9yCgotLS0KIGluY2x1ZGUvbGludXgvZnMuaCAgIHwgIDYgKysrKwoga2Vy
bmVsL21vZHVsZS9tYWluLmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2Zz
LmgKaW5kZXggMjFhOTgxNjgwODU2Li43MjJiNDJhNzdkNTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTI1NjYsNiArMjU2NiwxMiBA
QCBzdGF0aWMgaW5saW5lIGludCBkZW55X3dyaXRlX2FjY2VzcyhzdHJ1Y3QgZmlsZSAqZmlsZSkK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKIAlyZXR1cm4gYXRvbWlj
X2RlY191bmxlc3NfcG9zaXRpdmUoJmlub2RlLT5pX3dyaXRlY291bnQpID8gMCA6IC1FVFhUQlNZ
OwogfQorc3RhdGljIGlubGluZSBpbnQgZXhjbHVzaXZlX2Rlbnlfd3JpdGVfYWNjZXNzKHN0cnVj
dCBmaWxlICpmaWxlKQoreworCWludCBvbGQgPSAwOworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBm
aWxlX2lub2RlKGZpbGUpOworCXJldHVybiBhdG9taWNfdHJ5X2NtcHhjaGcoJmlub2RlLT5pX3dy
aXRlY291bnQsICZvbGQsIC0xKSA/IDAgOiAtRVRYVEJTWTsKK30KIHN0YXRpYyBpbmxpbmUgdm9p
ZCBwdXRfd3JpdGVfYWNjZXNzKHN0cnVjdCBpbm9kZSAqIGlub2RlKQogewogCWF0b21pY19kZWMo
Jmlub2RlLT5pX3dyaXRlY291bnQpOwpkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9tYWluLmMg
Yi9rZXJuZWwvbW9kdWxlL21haW4uYwppbmRleCAwNDRhYTJjOWUzY2IuLmI0YzdlOTI1ZmRiMCAx
MDA2NDQKLS0tIGEva2VybmVsL21vZHVsZS9tYWluLmMKKysrIGIva2VybmVsL21vZHVsZS9tYWlu
LmMKQEAgLTMwNTcsMTEgKzMwNTcsNTMgQEAgU1lTQ0FMTF9ERUZJTkUzKGluaXRfbW9kdWxlLCB2
b2lkIF9fdXNlciAqLCB1bW9kLAogCXJldHVybiBsb2FkX21vZHVsZSgmaW5mbywgdWFyZ3MsIDAp
OwogfQogCi1TWVNDQUxMX0RFRklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFy
IF9fdXNlciAqLCB1YXJncywgaW50LCBmbGFncykKK3N0YXRpYyBpbnQgZmlsZV9pbml0X21vZHVs
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKiB1YXJncywgaW50IGZsYWdz
KQogewogCXN0cnVjdCBsb2FkX2luZm8gaW5mbyA9IHsgfTsKIAl2b2lkICpidWYgPSBOVUxMOwog
CWludCBsZW47CisKKwlsZW4gPSBrZXJuZWxfcmVhZF9maWxlKGZpbGUsIDAsICZidWYsIElOVF9N
QVgsIE5VTEwsCisJCQkJICAgICAgIFJFQURJTkdfTU9EVUxFKTsKKwlpZiAobGVuIDwgMCkgewor
CQltb2Rfc3RhdF9pbmMoJmZhaWxlZF9rcmVhZHMpOworCQltb2Rfc3RhdF9hZGRfbG9uZyhsZW4s
ICZpbnZhbGlkX2tyZWFkX2J5dGVzKTsKKwkJcmV0dXJuIGxlbjsKKwl9CisKKwlpZiAoZmxhZ3Mg
JiBNT0RVTEVfSU5JVF9DT01QUkVTU0VEX0ZJTEUpIHsKKwkJaW50IGVyciA9IG1vZHVsZV9kZWNv
bXByZXNzKCZpbmZvLCBidWYsIGxlbik7CisJCXZmcmVlKGJ1Zik7IC8qIGNvbXByZXNzZWQgZGF0
YSBpcyBubyBsb25nZXIgbmVlZGVkICovCisJCWlmIChlcnIpIHsKKwkJCW1vZF9zdGF0X2luYygm
ZmFpbGVkX2RlY29tcHJlc3MpOworCQkJbW9kX3N0YXRfYWRkX2xvbmcobGVuLCAmaW52YWxpZF9k
ZWNvbXByZXNzX2J5dGVzKTsKKwkJCXJldHVybiBlcnI7CisJCX0KKwl9IGVsc2UgeworCQlpbmZv
LmhkciA9IGJ1ZjsKKwkJaW5mby5sZW4gPSBsZW47CisJfQorCisJcmV0dXJuIGxvYWRfbW9kdWxl
KCZpbmZvLCB1YXJncywgZmxhZ3MpOworfQorCisvKgorICoga2VybmVsX3JlYWRfZmlsZSgpIHdp
bGwgYWxyZWFkeSBkZW55IHdyaXRlIGFjY2VzcywgYnV0IG1vZHVsZQorICogbG9hZGluZyB3YW50
cyBfZXhjbHVzaXZlXyBhY2Nlc3MgdG8gdGhlIGZpbGUsIHNvIHdlIGRvIHRoYXQKKyAqIGhlcmUs
IGFsb25nIHdpdGggYmFzaWMgc2FuaXR5IGNoZWNrcy4KKyAqLworc3RhdGljIGludCBwcmVwYXJl
X2ZpbGVfZm9yX21vZHVsZV9sb2FkKHN0cnVjdCBmaWxlICpmaWxlKQoreworCWlmICghZmlsZSB8
fCAhKGZpbGUtPmZfbW9kZSAmIEZNT0RFX1JFQUQpKQorCQlyZXR1cm4gLUVCQURGOworCWlmICgh
U19JU1JFRyhmaWxlX2lub2RlKGZpbGUpLT5pX21vZGUpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwly
ZXR1cm4gZXhjbHVzaXZlX2Rlbnlfd3JpdGVfYWNjZXNzKGZpbGUpOworfQorCitTWVNDQUxMX0RF
RklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFyIF9fdXNlciAqLCB1YXJncywg
aW50LCBmbGFncykKK3sKKwlzdHJ1Y3QgZmQgZjsKIAlpbnQgZXJyOwogCiAJZXJyID0gbWF5X2lu
aXRfbW9kdWxlKCk7CkBAIC0zMDc1LDI4ICszMTE3LDE0IEBAIFNZU0NBTExfREVGSU5FMyhmaW5p
dF9tb2R1bGUsIGludCwgZmQsIGNvbnN0IGNoYXIgX191c2VyICosIHVhcmdzLCBpbnQsIGZsYWdz
KQogCQkgICAgICB8TU9EVUxFX0lOSVRfQ09NUFJFU1NFRF9GSUxFKSkKIAkJcmV0dXJuIC1FSU5W
QUw7CiAKLQlsZW4gPSBrZXJuZWxfcmVhZF9maWxlX2Zyb21fZmQoZmQsIDAsICZidWYsIElOVF9N
QVgsIE5VTEwsCi0JCQkJICAgICAgIFJFQURJTkdfTU9EVUxFKTsKLQlpZiAobGVuIDwgMCkgewot
CQltb2Rfc3RhdF9pbmMoJmZhaWxlZF9rcmVhZHMpOwotCQltb2Rfc3RhdF9hZGRfbG9uZyhsZW4s
ICZpbnZhbGlkX2tyZWFkX2J5dGVzKTsKLQkJcmV0dXJuIGxlbjsKKwlmID0gZmRnZXQoZmQpOwor
CWVyciA9IHByZXBhcmVfZmlsZV9mb3JfbW9kdWxlX2xvYWQoZi5maWxlKTsKKwlpZiAoIWVycikg
eworCQllcnIgPSBmaWxlX2luaXRfbW9kdWxlKGYuZmlsZSwgdWFyZ3MsIGZsYWdzKTsKKwkJYWxs
b3dfd3JpdGVfYWNjZXNzKGYuZmlsZSk7CiAJfQotCi0JaWYgKGZsYWdzICYgTU9EVUxFX0lOSVRf
Q09NUFJFU1NFRF9GSUxFKSB7Ci0JCWVyciA9IG1vZHVsZV9kZWNvbXByZXNzKCZpbmZvLCBidWYs
IGxlbik7Ci0JCXZmcmVlKGJ1Zik7IC8qIGNvbXByZXNzZWQgZGF0YSBpcyBubyBsb25nZXIgbmVl
ZGVkICovCi0JCWlmIChlcnIpIHsKLQkJCW1vZF9zdGF0X2luYygmZmFpbGVkX2RlY29tcHJlc3Mp
OwotCQkJbW9kX3N0YXRfYWRkX2xvbmcobGVuLCAmaW52YWxpZF9kZWNvbXByZXNzX2J5dGVzKTsK
LQkJCXJldHVybiBlcnI7Ci0JCX0KLQl9IGVsc2UgewotCQlpbmZvLmhkciA9IGJ1ZjsKLQkJaW5m
by5sZW4gPSBsZW47Ci0JfQotCi0JcmV0dXJuIGxvYWRfbW9kdWxlKCZpbmZvLCB1YXJncywgZmxh
Z3MpOworCWZkcHV0KGYpOworCXJldHVybiBlcnI7CiB9CiAKIC8qIEtlZXAgaW4gc3luYyB3aXRo
IE1PRFVMRV9GTEFHU19CVUZfU0laRSAhISEgKi8KLS0gCjIuNDEuMC5yYzEuNC5nYjRkYWU3NTA1
MAoK
--0000000000002e29d205fc8b1635--
