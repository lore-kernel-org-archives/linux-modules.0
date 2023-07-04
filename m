Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09CEB64D9
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGDNh4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGDNhy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF510CA
        for <linux-modules@vger.kernel.org>; Tue,  4 Jul 2023 06:37:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb41682472so8502572e87.2
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688477870; x=1691069870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWjiYG4F/kbaY9p70oD/qnrdrEEhJODCTs1UK2rFBxM=;
        b=OhsCB9vLWTg5GZSu/1Kj2RehfkuPbY6xUpevbQCGLtkzicNQ2cfma8T07X2im8G44L
         X+3M5K/4SUVyX4W5nPfGUeMQgfweCVnJhYvCxBPfxcMcugHKi9xACtZ0LS76WerhT0U9
         2sm336VbbUN3v2onv2CI5crEho9tBkLhzT+e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477870; x=1691069870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWjiYG4F/kbaY9p70oD/qnrdrEEhJODCTs1UK2rFBxM=;
        b=ZvIQLI6tj87ChH3iRqVHL7KOk9ZB7qYdjv7/PNgkEZem/3e4KPH8YooQp/dR8uODcA
         4Rptkre3PZcbHxLQV73S36/j7EBMYeGFwoYjgkluRJTaP/SH38y3ZexhZP8uxj2j1bXa
         Y9N95Q4GVIZhorlPmAUvFmmkoBfQVzcptrTzUSmSkBaKjz8R5qaNujhrasv9kof3jDkq
         Wpu10LIjI6XIlElc5fSfQZ5DN7VRc5M2T0igIpUI2KOUUhYGAowWEAAGqK0hDnY1YYq4
         XSvktAD0Rnf6j5usAV03wp+B5iwE/nnLwLCk2GUmrKFprtm/bEwPUOk75qZQ8SSOtTvc
         gW3Q==
X-Gm-Message-State: ABy/qLaB9CTyi9k2LbnLD3wRgsuqdtpzk9h3h9amNXUwWDxZ8dN7T4lk
        Vyus+4TiwTu4BkkLoeqoLD6lsXnM8P0+dXNC5JTpjwM8
X-Google-Smtp-Source: APBJJlGNKrPd5UYMMePQYla2mo9RkC8ad2fRZQdtPbjLPxuybgJ+L2PbifPoH47jxFO6goKlX0AcOw==
X-Received: by 2002:a05:6512:4005:b0:4fb:751a:98db with SMTP id br5-20020a056512400500b004fb751a98dbmr13798163lfb.63.1688477870095;
        Tue, 04 Jul 2023 06:37:50 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7ca4c000000b0051dfa2e30b2sm4938511edt.9.2023.07.04.06.37.49
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:37:49 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so4764868a12.3
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 06:37:49 -0700 (PDT)
X-Received: by 2002:aa7:c14b:0:b0:51a:265a:8fca with SMTP id
 r11-20020aa7c14b000000b0051a265a8fcamr8535529edp.27.1688477869051; Tue, 04
 Jul 2023 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com> <20230704100852.23452-1-vegard.nossum@oracle.com>
In-Reply-To: <20230704100852.23452-1-vegard.nossum@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 06:37:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Message-ID: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000098f0ae05ffa96368"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

--00000000000098f0ae05ffa96368
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jul 2023 at 03:09, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Commit 9b9879fc0327 added a hashtable storing lists of concurrent module
> loads. However, it didn't fix up all the error paths in
> init_module_from_file(); this would lead to leaving the function while an
> on-stack 'struct idempotent' element is still in the hash table, which
> leads to all sorts of badness as spotted by syzkaller:

You are of course 100% right.

However, I'd rather just use a wrapper function and make this thing
much clearer. Like I should have done originally.

So I'd be inclined towards a patch like the attached instead. Works for you?

                   Linus

--00000000000098f0ae05ffa96368
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljoc43bs0>
X-Attachment-Id: f_ljoc43bs0

IGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgMzIgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jCmlu
ZGV4IDgzNGRlODZlYmUzNS4uNTAwYTZhM2MyOTg3IDEwMDY0NAotLS0gYS9rZXJuZWwvbW9kdWxl
L21haW4uYworKysgYi9rZXJuZWwvbW9kdWxlL21haW4uYwpAQCAtMzA5Miw3ICszMDkyLDcgQEAg
c3RhdGljIGJvb2wgaWRlbXBvdGVudChzdHJ1Y3QgaWRlbXBvdGVudCAqdSwgY29uc3Qgdm9pZCAq
Y29va2llKQogICogcmVtb3ZlIGV2ZXJ5Ym9keSAtIHdoaWNoIGluY2x1ZGVzIG91cnNlbHZlcyAt
IGZpbGwgaW4gdGhlIHJldHVybgogICogdmFsdWUsIGFuZCB0aGVuIGNvbXBsZXRlIHRoZSBvcGVy
YXRpb24uCiAgKi8KLXN0YXRpYyB2b2lkIGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0IGlkZW1w
b3RlbnQgKnUsIGludCByZXQpCitzdGF0aWMgaW50IGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0
IGlkZW1wb3RlbnQgKnUsIGludCByZXQpCiB7CiAJY29uc3Qgdm9pZCAqY29va2llID0gdS0+Y29v
a2llOwogCWludCBoYXNoID0gaGFzaF9wdHIoY29va2llLCBJREVNX0hBU0hfQklUUyk7CkBAIC0z
MTA5LDIzICszMTA5LDE4IEBAIHN0YXRpYyB2b2lkIGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0
IGlkZW1wb3RlbnQgKnUsIGludCByZXQpCiAJCWNvbXBsZXRlKCZwb3MtPmNvbXBsZXRlKTsKIAl9
CiAJc3Bpbl91bmxvY2soJmlkZW1fbG9jayk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIGlu
dCBpbml0X21vZHVsZV9mcm9tX2ZpbGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2Vy
ICogdWFyZ3MsIGludCBmbGFncykKIHsKLQlzdHJ1Y3QgaWRlbXBvdGVudCBpZGVtOwogCXN0cnVj
dCBsb2FkX2luZm8gaW5mbyA9IHsgfTsKIAl2b2lkICpidWYgPSBOVUxMOwotCWludCBsZW4sIHJl
dDsKKwlpbnQgbGVuOwogCiAJaWYgKCFmIHx8ICEoZi0+Zl9tb2RlICYgRk1PREVfUkVBRCkpCiAJ
CXJldHVybiAtRUJBREY7CiAKLQlpZiAoaWRlbXBvdGVudCgmaWRlbSwgZmlsZV9pbm9kZShmKSkp
IHsKLQkJd2FpdF9mb3JfY29tcGxldGlvbigmaWRlbS5jb21wbGV0ZSk7Ci0JCXJldHVybiBpZGVt
LnJldDsKLQl9Ci0KIAlsZW4gPSBrZXJuZWxfcmVhZF9maWxlKGYsIDAsICZidWYsIElOVF9NQVgs
IE5VTEwsIFJFQURJTkdfTU9EVUxFKTsKIAlpZiAobGVuIDwgMCkgewogCQltb2Rfc3RhdF9pbmMo
JmZhaWxlZF9rcmVhZHMpOwpAQCAtMzE0Niw5ICszMTQxLDIyIEBAIHN0YXRpYyBpbnQgaW5pdF9t
b2R1bGVfZnJvbV9maWxlKHN0cnVjdCBmaWxlICpmLCBjb25zdCBjaGFyIF9fdXNlciAqIHVhcmdz
LCBpbnQKIAkJaW5mby5sZW4gPSBsZW47CiAJfQogCi0JcmV0ID0gbG9hZF9tb2R1bGUoJmluZm8s
IHVhcmdzLCBmbGFncyk7Ci0JaWRlbXBvdGVudF9jb21wbGV0ZSgmaWRlbSwgcmV0KTsKLQlyZXR1
cm4gcmV0OworCXJldHVybiBsb2FkX21vZHVsZSgmaW5mbywgdWFyZ3MsIGZsYWdzKTsKK30KKwor
c3RhdGljIGludCBpZGVtcG90ZW50X2luaXRfbW9kdWxlKHN0cnVjdCBmaWxlICpmLCBjb25zdCBj
aGFyIF9fdXNlciAqIHVhcmdzLCBpbnQgZmxhZ3MpCit7CisJc3RydWN0IGlkZW1wb3RlbnQgaWRl
bTsKKworCS8qIFNlZSBpZiBzb21lYm9keSBlbHNlIGlzIGRvaW5nIHRoZSBvcGVyYXRpb24/ICov
CisJaWYgKGlkZW1wb3RlbnQoJmlkZW0sIGZpbGVfaW5vZGUoZikpKSB7CisJCXdhaXRfZm9yX2Nv
bXBsZXRpb24oJmlkZW0uY29tcGxldGUpOworCQlyZXR1cm4gaWRlbS5yZXQ7CisJfQorCisJLyog
T3RoZXJ3aXNlLCB3ZSdsbCBkbyBpdCBhbmQgY29tcGxldGUgb3RoZXJzICovCisJcmV0dXJuIGlk
ZW1wb3RlbnRfY29tcGxldGUoJmlkZW0sCisJCWluaXRfbW9kdWxlX2Zyb21fZmlsZShmLCB1YXJn
cywgZmxhZ3MpKTsKIH0KIAogU1lTQ0FMTF9ERUZJTkUzKGZpbml0X21vZHVsZSwgaW50LCBmZCwg
Y29uc3QgY2hhciBfX3VzZXIgKiwgdWFyZ3MsIGludCwgZmxhZ3MpCkBAIC0zMTY4LDcgKzMxNzYs
NyBAQCBTWVNDQUxMX0RFRklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFyIF9f
dXNlciAqLCB1YXJncywgaW50LCBmbGFncykKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlmID0gZmRn
ZXQoZmQpOwotCWVyciA9IGluaXRfbW9kdWxlX2Zyb21fZmlsZShmLmZpbGUsIHVhcmdzLCBmbGFn
cyk7CisJZXJyID0gaWRlbXBvdGVudF9pbml0X21vZHVsZShmLmZpbGUsIHVhcmdzLCBmbGFncyk7
CiAJZmRwdXQoZik7CiAJcmV0dXJuIGVycjsKIH0K
--00000000000098f0ae05ffa96368--
