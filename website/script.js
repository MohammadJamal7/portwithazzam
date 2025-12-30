function showTerms() {
  showModal('شروط الخدمة', `
    <ul>
      <li>يجب الالتزام بجميع القوانين المحلية والدولية.</li>
      <li>يحق للشركة تعديل أو إنهاء الخدمة في أي وقت.</li>
      <li>المعلومات المقدمة يجب أن تكون صحيحة ودقيقة.</li>
    </ul>
  `);
}

function showPrivacy() {
  showModal('سياسة الخصوصية', `
    <p>نلتزم بحماية خصوصيتك وعدم مشاركة بياناتك مع أي طرف ثالث إلا بموافقتك أو حسب القانون.</p>
  `);
}

function showModal(title, content) {
  document.getElementById('modal-body').innerHTML = `<h4>${title}</h4>${content}`;
  document.getElementById('modal').style.display = 'flex';
}

function closeModal() {
  document.getElementById('modal').style.display = 'none';
}

document.getElementById('contactForm').onsubmit = function(e) {
  e.preventDefault();
  alert('تم إرسال رسالتك بنجاح! سنقوم بالرد عليك قريباً.');
  this.reset();
};

function shareSite() {
  const siteUrl = 'https://azzamimexport.netlify.app/';
  if (navigator.share) {
    navigator.share({
      title: 'شركة العزام للاستيراد والتصدير',
      text: 'جرب موقع شركة العزام للاستيراد والتصدير!',
      url: siteUrl
    });
  } else {
    alert('انسخ الرابط وشاركه: ' + siteUrl);
  }
}
